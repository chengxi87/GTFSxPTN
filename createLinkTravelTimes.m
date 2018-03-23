function S = createLinkTravelTimes(lineIdList,date,prefix)
% open file path
filepath = uigetdir(pwd,'Select the output folder of GTFS timetable');
% 
S = struct('oStop',[],'dStop',[],'data',[],'hourlyAvg',[]);
nLinks = 0;
for lineID = lineIdList
    filename = [prefix '_' int2str(lineID) '_' date '.mat'];
    load([filepath,'\',filename]);
    
    for k = 1:length(TripDetail)-1
        if TripDetail(k).gtfsTripID == TripDetail(k+1).gtfsTripID % same trip check
            oStop = processStopID(TripDetail(k).stopID);
            dStop = processStopID(TripDetail(k+1).stopID);
            scheArrTime = TripDetail(k).gtfsArrival;
            scheTravelTime = TripDetail(k+1).gtfsArrival - TripDetail(k).gtfsDeparture;
            data = [lineID,scheArrTime,scheTravelTime];
            
            idx = find([S.oStop] == oStop & [S.dStop] == dStop);
            if isempty(idx)
                nLinks = nLinks + 1;
                S(nLinks).oStop = oStop;
                S(nLinks).dStop = dStop;
                S(nLinks).data = [S(nLinks).data data];
            else
                S(idx).data = [S(idx).data;data];
            end
        end % end outter if
    end % end TripDetail loop
end

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
        
        idx = (data(:,2) >= stInSec & data(:,2) <= etInSec);        
        avg = ceil(mean(data(idx,3)));       
        result = [st,avg];     
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