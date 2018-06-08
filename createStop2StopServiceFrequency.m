function S = createStop2StopServiceFrequency(lineIdList,date,prefix)
%%
% Description
% -----------

% 
% Parameters
% ----------

%
% Returns
% -------

%%
% open file path
filepath = uigetdir(pwd,'Select the output folder of GTFS timetable');

% initialize the resulting struct
S = struct('ID',[],'fromStopID',[],'toStopID',[],'data',[],'hourlyAvg',[]);
nStopPairs = 0;

for lineID = lineIdList
    filename = [prefix '_' int2str(lineID) '_' date '.mat'];
    load([filepath,'\',filename]);
    % loop over each trip
    for k = 1:length(TripSummary)
        curTripID = TripSummary(k).gtfsTripID;
        rowIDs = find([TripDetail.gtfsTripID] == curTripID);
        % build connection between each stop pair
        for m = 1:length(rowIDs)-1
            depTime = TripDetail(rowIDs(m)).gtfsDeparture;
            data = [lineID,depTime];
            for n = (m+1):length(rowIDs)
                fromStopID = processStopID(TripDetail(rowIDs(m)).stopID);
                toStopID = processStopID(TripDetail(rowIDs(n)).stopID);
                idx = find([S.fromStopID] == fromStopID & [S.toStopID] == toStopID);
                if isempty(idx)
                    nStopPairs = nStopPairs + 1;
                    S(nStopPairs).ID = nStopPairs;
                    S(nStopPairs).fromStopID = fromStopID;
                    S(nStopPairs).toStopID = toStopID;
                    S(nStopPairs).data = [S(nStopPairs).data;data];
                else
                    S(idx).data = [S(idx).data;data];
                end              
            end
        end
    end   
    disp(['Line ',int2str(lineID), ' is completed...']);
end % end line loop

S = aggregateData(S);
end

%%
function S = aggregateData(S)

for i = 1:length(S)
    data = S(i).data;
    for st = 5:24
        et = st + 1;
        stInSec = st * 3600;
        etInSec = et * 3600;
        
        idx = find(data(:,2) >= stInSec & data(:,2) <= etInSec);  
        if ~isempty(idx)
            v = length(idx);
        else
            v = 0;
        end
        result = [st,v];     
        S(i).hourlyAvg = [S(i).hourlyAvg;result];
    end
end

end
%%
function stopIdInt = processStopID(oriStopId)
if isnumeric(oriStopId)
    stopIdInt = oriStopId;
else
    strs = split(oriStopId,':');
    stopIdInt = str2num(strs{2});
end
end


