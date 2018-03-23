function Routes = buildPlanningRoutes(OPTN,StopIdxTable,LinkIdxTable)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib']);

Routes = struct('routeID',[],'dirID',[],'type',[],'destination',[],'stops',[],'links',[]);

for i = 1:length(OPTN.Routes)
    Routes(i).routeID = OPTN.Routes(i).routeID;
    Routes(i).dirID = OPTN.Routes(i).dirID;
    Routes(i).type = OPTN.Routes(i).type;
    Routes(i).destination = OPTN.Routes(i).destination;
    
    stops = OPTN.Routes(i).stops;
    for operationStopID = stops
        planningStopID = findPlanningStopID(operationStopID,StopIdxTable);
        Routes(i).stops = [Routes(i).stops planningStopID];
    end
    
    links = OPTN.Routes(i).links;
    for k = 1:length(links)
        operationLinkID = links(k);
        planningLinkID = findPlanningLinkID(operationLinkID,LinkIdxTable);
        Routes(i).links = [Routes(i).links planningLinkID];
    end
end
end

%%
function planningLinkID = findPlanningLinkID(operationLinkID,LinkIdxTable)
idx = [LinkIdxTable.operationLinkID] == operationLinkID;
planningLinkID = LinkIdxTable(idx).planningLinkID;
end

%%
function planningStopID = findPlanningStopID(operationStopID,StopIdxTable)
idx = [StopIdxTable.operationStopID] == operationStopID;
planningStopID = StopIdxTable(idx).planningStopID;
end

    
    
    
    