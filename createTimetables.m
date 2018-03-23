function createTimetables()

%% Parameter setting
% gtfs file path and name
[filename,filepath]=uigetfile({'*.mat'},...
    'Select a gtfs file stored in .mat');
load([filepath filename]);

prompt = {'gtfs file:','date (YYYYMMDD):'};
dlg_title = 'Input for timetable building';
defaultans = {[filepath,'\',filename],''};
num_lines = 2;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

date = answer{2};

% Select a mode and create sub-network (mode-specific)
% modeTypeID = 0;
[s,~]=listdlg('liststring',{'Metro','Bus','Tram'},...
      'OkString','OK','CancelString','Cancel',...
     'promptstring','Mode list','name','Select PT modes','selectionmode','multiple');
 
 routeTypeList = [];
 for i = s
     if i == 1
         routeTypeList = [routeTypeList 1];
     elseif i == 2
         routeTypeList = [routeTypeList 3];
     elseif i == 3
         routeTypeList = [routeTypeList 0];
     end
 end

%% Get all tables
routesTable = getTable('routes',gtfsTables);
tripsTable = getTable('trips',gtfsTables);
calendardatesTable = getTable('calendar_dates',gtfsTables);
stoptimesTable = getTable('stop_times',gtfsTables);
% stopsTable = getTable('stops',gtfsTables); % no use in this script
% shapesTable = getTable('shapes',gtfsTables); % no use in this script
clear gtfsTables;
% convert stoptimes to make the process faster
stoptimes = table2cell(stoptimesTable);
clear stoptimesTable;

% use the common function 'getServiceIdList' to obtain the serviceIdList of
% the specified date
serviceIdList = getServiceIdList(calendardatesTable,date);

startRow = 1; % start row can be adjusted to save time
for iRoute = startRow:size(routesTable,1)
    tic;
    curRouteID = routesTable.route_id(iRoute);
    curRouteType = routesTable.route_type(iRoute);
    % skip the modes that are not needed
    if ~ismember(curRouteType,routeTypeList)
        continue;
    end
    
    try
        % use the common function 'getTripList' to obtain a cell containing
        % information of all the trips from the specified route and date
        curTripList = getTripList(tripsTable,curRouteID,serviceIdList);
        % the 'tripList' is the input for the daily timetable building
        [TripSummary,TripDetail] = buildTimetable(curTripList,stoptimes,...
            curRouteID,date);
        % save data
        dataFileName = [char(curRouteID), '_', date,'.mat'];
        dataFileName = strrep(dataFileName,':','_');
        save(dataFileName,'TripSummary','TripDetail');
        fprintf([dataFileName ' created...\n']);
    catch
        fprintf(['*********** ' char(curRouteID) ' has a problem...\n']);
    end
    toc;
end

end


%% Subfunction: buildTimetable (one day, one route with both directions)
function [TripSummary,TripDetail] = buildTimetable(tripList,stoptimes,routeID,date)
% In the Dutch case of GTFS, trip_short_name is the trip id that can be
% used to connect AVL data
TripSummary = [];
TripDetail = [];
% sort tripList based on the trip_short_name
[~, idx] = sort(cell2mat(tripList(:,3)));
tripList = tripList(idx,:);

nTripRecords = 0;
for i = 1:size(tripList,1)

    TripSummary(i).lineID = routeID;
    TripSummary(i).date = date;
    TripSummary(i).gtfsTripID = tripList{i,3};
    TripSummary(i).dirID = tripList{i,4};
    
    tripID = tripList{i,1};
    idxList = find(strcmp(tripID,{stoptimes{:,1}}));
    curTrip = stoptimes(idxList,:);
    % sort curTrip based on the stop sequence
    [~, idx] = sort(cell2mat(curTrip(:,2)));
    curTrip = curTrip(idx,:);
    
    for j = 1:size(curTrip,1)
        nTripRecords = nTripRecords + 1;
        TripDetail(nTripRecords).gtfsTripID = TripSummary(i).gtfsTripID;
        TripDetail(nTripRecords).stopID = curTrip{j,3};
        TripDetail(nTripRecords).sequence = curTrip{j,2};    
        TripDetail(nTripRecords).gtfsArrival = convertTime(curTrip{j,4});
        TripDetail(nTripRecords).gtfsDeparture = convertTime(curTrip{j,5});
    end
end
end % end function




%% Subfunction: convertTime
function seconds = convertTime(time)
strs = strsplit(time,':');
h = str2num(strs{1});
m = str2num(strs{2});
s = str2num(strs{3});
seconds = h * 3600 + m * 60 + s;
end