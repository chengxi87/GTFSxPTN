function [G,adj] = buildWeightedPGraphMS(PTN,SF,hourList)
%%
% Description
% -----------
% build a directed Weighted P-space Graph at the middle scale based on the
% Public Transport Network. The weight considered corresponds to the stop-
% to-stop service frequency.
% 
% Parameters
% ----------
% PTN: struct
%   the middle-scale PTN 
% SF: struct
%   Service Frequency
% hourList: int array
%   a list of hours showing the period of time of the day
%
% Returns
% -------
% G: MATLAB Graph object
%   The graph contains no self loops.
% adj: matrix array
%   adjacency matrix for the L-space graph.        

%%
nStops = length(PTN.Stops);
adj = zeros(nStops,nStops);
N = adj;

for i = 1:length(SF)
    try
        o = PTN.StopIdxTable([PTN.StopIdxTable.stopIdBS]== SF(i).fromStopID).stopIdMS;
        d = PTN.StopIdxTable([PTN.StopIdxTable.stopIdBS]== SF(i).toStopID).stopIdMS;
        for hour = hourList
            rowIdx = find(SF(i).hourlyAvg(:,1) == hour);
            N(o,d) = N(o,d) + SF(i).hourlyAvg(rowIdx,2);
        end
    catch
        disp(['stop pair (', int2str(SF(i).fromStopID), ',',...
            int2str(SF(i).toStopID), ') was not found in the current PTN.']);
    end
end
adj = round(0.5 * (length(hourList)*60)./N);
adj(adj==Inf) = 0;

G = digraph(adj,'OmitSelfLoops');
G.Nodes.Names = {PTN.Stops.name}';
G.Nodes.x = [PTN.Stops.x]';
G.Nodes.y = [PTN.Stops.y]';

end