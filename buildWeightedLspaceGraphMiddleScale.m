function [G,adj] = buildWeightedLspaceGraphMiddleScale(PTN,LTT,SF,hourlist)


nStops = length(PTN.Stops);
adj = zeros(nStops,nStops);
for i = 1:length(PTN.Links)
    % basic connection
    adj(PTN.Links(i).oStop,PTN.Links(i).dStop) = 1; 
end

% calculate different weights
travelTimeList = buildTravelTimeList(PTN,LTT,hourlist);
serviceFrequencyList = buildServiceFrequencyList(PTN,SF,hourlist);

% add weights to the graph
G = digraph(adj);
G.Edges.TravelTime = zeros(size(G.Edges,1),1);
G.Edges.ServiceFrequency = zeros(size(G.Edges,1),1);
for k = 1:size(G.Edges,1)
    oNode = G.Edges.EndNodes(k,1);
    dNode = G.Edges.EndNodes(k,2);
    rowIDinLinks = find([PTN.Links.oStop] == oNode & [PTN.Links.dStop] == dNode);
    G.Edges.TravelTime(k) = travelTimeList(rowIDinLinks);
    G.Edges.ServiceFrequency(k) = serviceFrequencyList(rowIDinLinks);
end


G.Nodes.Names = {PTN.Stops.name}';
G.Nodes.x = [PTN.Stops.x]';
G.Nodes.y = [PTN.Stops.y]';

end



