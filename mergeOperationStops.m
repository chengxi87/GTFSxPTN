function [Stops,StopIdxTable] = mergeOperationStops(OPTN,alpha,plotSwtich)
%%
% INPUT
%  - OPTN: Operation Public Transport Network
%  - alpha: Stop clusters within this percentile of distance will be merged 
% OUTPUT
%  - Stops: Final merged stops from operation level
%  - StopIdxTable: stop index table between two levels
% ---- 
%%
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib']);

% Intra-route merging based on route ID and stop name
TmpStops = doIntraRouteStopMerging(OPTN);

% Inter-route merging, Part 1: based on stop name and child stops
firstMergingList = findRowsToBeMergedBasedOnChildStops(TmpStops);
TmpStops = mergeStopsWithMergeList(firstMergingList,TmpStops);

% Inter-route merging, Part 2: based on distance and route ID
% For each stop, find its closest neighbor from other routes
Neighbors =  findClosestStopFromOtherRoute(TmpStops);
dt = prctile([Neighbors.dist],alpha); % distance threshold 
idxList = find([Neighbors.dist] <= dt);

finalMergingList = determineFinalMergingList(idxList,TmpStops,Neighbors);
Stops = mergeStopsWithMergeList(finalMergingList,TmpStops);

% update stop IDs
StopIdxTable = [];
m = 0;
for j = 1:length(Stops)
    Stops(j).ID = j;
    for x = Stops(j).childStops
        m = m + 1;
        StopIdxTable(m).operationStopID = x;
        StopIdxTable(m).planningStopID = j;
    end
end

Stops = rmfield(Stops, 'coord');

%   
if plotSwtich
    visualCheck(OPTN,TmpStops,Neighbors,idxList);
end
    
end

%%
function visualCheck(OPTN,TmpStops,Neighbors,idxList)
% plot to check
plotNetworkWithGeo(OPTN.Links,OPTN.Stops);
hold on;
scatter([TmpStops.x],[TmpStops.y],10,'g','filled');
hold on;
for k = 1:length(TmpStops)
    text(TmpStops(k).x,TmpStops(k).y,TmpStops(k).name,'Color','red','FontSize',8);
    hold on ;
end

for idx = idxList
    plot([Neighbors(idx).firstCoord(1),Neighbors(idx).secondCoord(1)],...
        [Neighbors(idx).firstCoord(2),Neighbors(idx).secondCoord(2)],'-.r',...
        'LineWidth',2);
    hold on;
    text(Neighbors(idx).firstCoord(1),Neighbors(idx).firstCoord(2),Neighbors(idx).firstName);
    hold on;
    text(Neighbors(idx).secondCoord(1),Neighbors(idx).secondCoord(2),Neighbors(idx).secondName);
end

end