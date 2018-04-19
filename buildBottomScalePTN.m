function [Routes,Stops,Links] = buildBottomScalePTN(gtfsTables,date,routeTypeList)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib']);
%% Get all tables
routesTable = getTable('routes',gtfsTables);
tripsTable = getTable('trips',gtfsTables);
calendardatesTable = getTable('calendar_dates',gtfsTables);
stoptimesTable = getTable('stop_times',gtfsTables);
stopsTable = getTable('stops',gtfsTables);
shapesTable = getTable('shapes',gtfsTables);
% stopsTable = getTable('stops',gtfsTables); % no use in this script
% shapesTable = getTable('shapes',gtfsTables); % no use in this script
clear gtfsTables;
% convert stoptimes to make the process faster
stoptimes = table2cell(stoptimesTable);
clear stoptimesTable;

%%
Routes = struct('routeID',[],'dirID',[],'destination',[],...
    'type',[],'stops',[],'links',[]);
Stops = struct('ID',[],'name',[],'x',[],'y',[]);
Links = struct('ID',[],'oStop',[],'dStop',[],'geometry',[]);

nRoutes = 0;
nStops = 0;
nLinks = 0;

% get all the service IDs from the date
serviceIdList = getServiceIdList(calendardatesTable,date);

startRow = 1; % start row can be adjusted to save time
for k = startRow:size(routesTable,1)
    curRouteType = routesTable.route_type(k);
    if ~ismember(curRouteType,routeTypeList)
        continue;
    end
    
    routeID = routesTable.route_id(k);
    try
        % fetch all the trips of the current route ID
        tripList = getTripList(tripsTable,routeID,serviceIdList);
        % find unique directions of this route
        dirIdList = unique(cell2mat(tripList(:,4)))';
        
        for dirID = dirIdList
            nRoutes = nRoutes + 1;
            % get full stop sequence of current Route
            [fullStopSequence,finalTripDes,finalShapeID] = ...
                findFullStopSequence(dirID,tripList,stoptimes);
            
            Routes(nRoutes).routeID = char(routeID);
            Routes(nRoutes).dirID = dirID;
            Routes(nRoutes).destination = finalTripDes;
            Routes(nRoutes).type = curRouteType;
            
            % build Stops
            Routes(nRoutes).stops = [];
            for i = 1:size(fullStopSequence,1)
                val = fullStopSequence{i,1};
                idx = find(strcmp(val,stopsTable.stop_id));
                stopID = stopsTable.stop_code(idx);
                Routes(nRoutes).stops = [Routes(nRoutes).stops stopID];
                if ~ismember(stopID,[Stops.ID])
                    nStops = nStops + 1;
                    Stops(nStops).ID = stopID;
                    Stops(nStops).name = char(stopsTable.stop_name(idx));
                    Stops(nStops).x = stopsTable.stop_lon(idx);
                    Stops(nStops).y = stopsTable.stop_lat(idx);
                end
            end
            
            % build Links
            Routes(nRoutes).links = [];
            curStops = Routes(nRoutes).stops;
            % link shape coords
            idx = find([shapesTable.shape_id == finalShapeID]);
            shapeCoords = [shapesTable.shape_pt_lon(idx),shapesTable.shape_pt_lat(idx)];
            for j = 1:length(curStops) - 1
                oStop = curStops(j);
                dStop = curStops(j+1);
                
                idx = find([Links.oStop] == oStop & [Links.dStop] == dStop);
                if isempty(idx)
                    nLinks = nLinks + 1;
                    Links(nLinks).ID = nLinks;
                    Links(nLinks).oStop = oStop;
                    Links(nLinks).dStop = dStop;
                    geometry = extractGeometry(oStop,dStop,Stops,shapeCoords);
                    Links(nLinks).geometry = geometry;
                    
                    Routes(nRoutes).links = [Routes(nRoutes).links Links(nLinks).ID];
                else
                    Routes(nRoutes).links = [Routes(nRoutes).links Links(idx).ID];
                end
            end
            
        end
    catch
        disp(strcat('Problem happens to route:', char(routeID)));
    end
    
end

end % end function