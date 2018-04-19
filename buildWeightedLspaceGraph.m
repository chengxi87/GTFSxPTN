function [G,adj] = buildWeightedLspaceGraph(PPTN,LTT,SF,hourlist)

% PPTN: Planning Public Transport Network
% OLTT: Operations Link Travel Times

nStops = length(PPTN.Stops);
adj = zeros(nStops,nStops);
for i = 1:length(PPTN.Links)
    % basic connection
    adj(PPTN.Links(i).oStop,PPTN.Links(i).dStop) = 1; 
end

% calculate different weights
travelTimeList = buildTravelTimeList(PPTN,LTT,hourlist);
serviceFrequencyList = buildServiceFrequencyList(PPTN,SF,hourlist);

% add weights to the graph
G = digraph(adj);
G.Edges.TravelTime = travelTimeList;
G.Edges.ServiceFrequency = serviceFrequencyList;

G.Nodes.Names = {PPTN.Stops.name}';
G.Nodes.x = [PPTN.Stops.x]';
G.Nodes.y = [PPTN.Stops.y]';

end



