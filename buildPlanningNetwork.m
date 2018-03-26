function [Stops,Links,Routes,StopIdxTable,LinkIdxTable] = buildPlanningNetwork(OPTN,theta)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib']);
addpath([str_temp,'\_lib\stop_merging']);


% Stops
% theta is the parameter about distance threshold
Stops = doOperationStopMerging(OPTN,theta);
% update stop IDs
StopIdxTable = [];
n = 0;
for i = 1:length(Stops)
    Stops(i).ID = i;
    for j = Stops(i).childStops
        n = n + 1;
        StopIdxTable(n).operationStopID = j;
        StopIdxTable(n).planningStopID = i;
    end
end

% Links
[Links,LinkIdxTable] = buildPlanningLinks(OPTN,StopIdxTable);
% Routes
Routes = buildPlanningRoutes(OPTN,StopIdxTable,LinkIdxTable); 



end