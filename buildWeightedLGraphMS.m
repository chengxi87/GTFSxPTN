function [G,adj] = buildWeightedLGraphMS(PTN,LTT,SF,hourList)
%%
% Description
% -----------
% build a directed Weighted L-space Graph at the middle scale based on the
% Public Transport Network. Two types of weights are considered in this script,
% including the in-vehicle travel time and service frequency between two 
% consecutive stops.
% 
% Parameters
% ----------
% PTN: struct
%   the target middle-scale PTN 
% LTT: struct
%   Link Travel Time. 
% SF: struct
% 
% hourList
% Returns
% -------
% G: MATLAB Graph object
%   The graph contains no self loops.
% adj: matrix array
%   adjacency matrix for the L-space graph.        

%%

nStops = length(PTN.Stops);
adj = zeros(nStops,nStops);
for i = 1:length(PTN.Links)
    % basic connection
    adj(PTN.Links(i).oStop,PTN.Links(i).dStop) = 1; 
end

% calculate different weights
travelTimeList = buildTravelTimeList(PTN,LTT,hourList);
serviceFrequencyList = buildServiceFrequencyList(PTN,SF,hourList);

% add weights to the graph
G = digraph(adj,'OmitSelfLoops');
G.Edges.TravelTime = zeros(size(G.Edges,1),1);
G.Edges.ServiceFrequency = zeros(size(G.Edges,1),1);
for k = 1:size(G.Edges,1)
    oNode = G.Edges.EndNodes(k,1);
    dNode = G.Edges.EndNodes(k,2);
    idx = find([PTN.Links.oStop] == oNode & [PTN.Links.dStop] == dNode);
    G.Edges.TravelTime(k) = travelTimeList(idx);  
    G.Edges.ServiceFrequency(k) = serviceFrequencyList(idx);
end
% replace those NAN values with the mean of rest
p = find(isnan(G.Edges.TravelTime));
G.Edges.TravelTime(p) = round(nanmean(G.Edges.TravelTime));

G.Nodes.Names = {PTN.Stops.name}';
G.Nodes.x = [PTN.Stops.x]';
G.Nodes.y = [PTN.Stops.y]';

end



