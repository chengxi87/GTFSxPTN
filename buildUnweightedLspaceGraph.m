function [G,adj] = buildUnweightedLspaceGraph(PPTN)

nStops = length(PPTN.Stops);
adj = zeros(nStops,nStops);

for i = 1:length(PPTN.Links)
    adj(PPTN.Links(i).oStop,PPTN.Links(i).dStop) = 1;
end
G = digraph(adj,'OmitSelfLoops');

G.Nodes.Names = {PPTN.Stops.name}';
G.Nodes.x = [PPTN.Stops.x]';
G.Nodes.y = [PPTN.Stops.y]';

end