function Routes = buildMiddleScaleRoutes(BPTN,StopIdxTable,LinkIdxTable)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib\bottom2middle']);

Routes = struct('routeID',[],'dirID',[],'type',[],'destination',[],'stops',[],'links',[]);

for i = 1:length(BPTN.Routes)
    Routes(i).routeID = BPTN.Routes(i).routeID;
    Routes(i).dirID = BPTN.Routes(i).dirID;
    Routes(i).type = BPTN.Routes(i).type;
    Routes(i).destination = BPTN.Routes(i).destination;
    
    stops = BPTN.Routes(i).stops;
    for stopIdBS = stops
        stopIdMS = findStopID(stopIdBS,StopIdxTable);
        Routes(i).stops = [Routes(i).stops stopIdMS];
    end
    
    links = BPTN.Routes(i).links;
    for k = 1:length(links)
        linkIdBS = links(k);
        linkIdMS = findLinkID(linkIdBS,LinkIdxTable);
        Routes(i).links = [Routes(i).links linkIdMS];
    end
end
end

%%
function linkIdMS = findLinkID(linkIdBS,LinkIdxTable)
idx = [LinkIdxTable.linkIdBS] == linkIdBS;
linkIdMS = LinkIdxTable(idx).linkIdMS;
end

%%
function stopIdMS = findStopID(stopIdBS,StopIdxTable)
idx = [StopIdxTable.stopIdBS] == stopIdBS;
stopIdMS = StopIdxTable(idx).stopIdMS;
end

    
    
    
    