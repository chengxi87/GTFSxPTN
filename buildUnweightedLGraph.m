function [G,adj] = buildUnweightedLGraph(PTN)
%%
% Description
% -----------
% build an directed unweighted L-space Graph based on the Public Transport Network.
% Here the PTN can be either middle or top scale.
% 
% Parameters
% ----------
% PTN: struct
%   middle- or top- scale PTN struct 
%
% Returns
% -------
% G: MATLAB Graph object
%   The graph contains no self loops.
% adj: matrix
%   adjacency matrix for the L-space graph.        

%%
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