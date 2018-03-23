function [G,adj] = buildWeightedLspaceGraph(PPTN,OLTT,hourlist)

% PPTN: Planning Public Transport Network
% OLTT: Operations Link Travel Times

nStops = length(PPTN.SuperStops);
adj = zeros(nStops,nStops);

for i = 1:length(PPTN.SuperLinks)
    adj(PPTN.SuperLinks(i).oStop,PPTN.SuperLinks(i).dStop) = 1;
end
G = digraph(adj,'OmitSelfLoops');

G.Nodes.Names = {PPTN.SuperStops.name}';
G.Nodes.x = [PPTN.SuperStops.x]';
G.Nodes.y = [PPTN.SuperStops.y]';






end