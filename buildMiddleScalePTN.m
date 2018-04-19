function [Stops,Links,Routes,StopIdxTable,LinkIdxTable] = buildMiddleScalePTN(BSPTN,theta)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib\bottom2middle']);


% Stops
% theta is the parameter about distance threshold
Stops = doStopMerging4BSPTN(BSPTN,theta);
% update stop IDs
StopIdxTable = [];
n = 0;
for i = 1:length(Stops)
    Stops(i).ID = i;
    for j = Stops(i).childStops
        n = n + 1;
        StopIdxTable(n).stopIdBS = j;
        StopIdxTable(n).stopIdMS = i;
    end
end

% Links
[Links,LinkIdxTable] = buildMiddleScaleLinks(BSPTN,StopIdxTable);
% Routes
Routes = buildMiddleScaleRoutes(BSPTN,StopIdxTable,LinkIdxTable); 

end