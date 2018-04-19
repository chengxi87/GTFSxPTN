function [TSStops,TSLinks,TSRoutes,LinkIdxTable] = buildTopScalePTN(MPTN)

[G,~] = buildUnweightedLspaceGraph(MPTN);

indegree = centrality(G,'indegree');
outdegree = centrality(G,'outdegree');
totaldegree = indegree + outdegree;

nRoutes = length(MPTN.Routes);
TSRoutes = MPTN.Routes;
TSRoutes = rmfield(TSRoutes, 'stops');
TSRoutes = rmfield(TSRoutes, 'links');

TSStops = [];
TSLinks = [];
nTSstops = 0;
nTSlinks = 0;
LinkIdxTable = [];

for i = 1:nRoutes
    oldStops = MPTN.Routes(i).stops;
    oldLinks = MPTN.Routes(i).links;
    
    newStops = [];
    nNewStops = 0;
    newLinks = [];
    for k = 1:length(oldStops)
        stopID = oldStops(k);
        if k == 1 | k== length(oldStops)
            doRemove = 0;
        else
            if totaldegree(stopID) == 2 | totaldegree(stopID) == 4
                doRemove = 1;
            else
                doRemove = 0;
            end
        end
        
        if ~doRemove
            % reserve this stop
            nNewStops = nNewStops + 1;
            newStops = [newStops stopID];
            % build TS Stops
            TSStops = addStop(TSStops,MPTN.Stops,stopID);
            % build TS Links
            
            if k ~= 1
                oStop = MPTN.Links(childLinks(1)).oStop;
                dStop = MPTN.Links(childLinks(end)).dStop;
                [TSlinkId,TSLinks,LinkIdxTable] = addLink(oStop,dStop,TSLinks,childLinks,LinkIdxTable);
                newLinks = [newLinks TSlinkId];
            end
            if k ~= length(oldStops)
                childLinks = [oldLinks(k)];
            end
            
        else
            % remove this stops and add this link to the child set of the new link
            childLinks = [childLinks,oldLinks(k)];
        end  
    end
    TSRoutes(i).stops = newStops;
    TSRoutes(i).links = newLinks;
end
end

%%
function TSStops = addStop(TSStops,MSStops,stopID)
if isempty(TSStops) | ~ismember(stopID,[TSStops.ID])
    TSStops = [TSStops;MSStops(stopID)];
end
end

%%
function [TSlinkId,TSLinks,LinkIdxTable] = addLink(oStop,dStop,TSLinks,childLinks,LinkIdxTable)

if isempty(TSLinks) | isempty(find([TSLinks.oStop] == oStop & [TSLinks.dStop] == dStop))
    nLinks = length(TSLinks)+1;
    TSLinks(nLinks).ID = nLinks;
    TSLinks(nLinks).oStop = oStop;
    TSLinks(nLinks).dStop = dStop;
    TSLinks(nLinks).childLinks = childLinks;
    
    for i = 1:length(childLinks)
        m = length(LinkIdxTable);
        LinkIdxTable(m+1).linkIdMS = childLinks(i);
        LinkIdxTable(m+1).linkIdTS = TSLinks(nLinks).ID;
    end
end
TSlinkId = TSLinks(find([TSLinks.oStop] == oStop & [TSLinks.dStop] == dStop)).ID;
end