function [G,adj] = buildUnweightedLspaceGraph(PTN)

nStops = length(PTN.Stops);
adj = zeros(nStops,nStops);

for i = 1:length(PTN.Links)
    adj(PTN.Links(i).oStop,PTN.Links(i).dStop) = 1;
end
G = digraph(adj,'OmitSelfLoops');

G.Nodes.Names = {PTN.Stops.name}';
G.Nodes.x = [PTN.Stops.x]';
G.Nodes.y = [PTN.Stops.y]';

end