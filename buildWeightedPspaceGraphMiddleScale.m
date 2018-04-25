
function [G,adj] = buildWeightedPspaceGraphMiddleScale(MPTN,SF,hourlist)

nStops = length(MPTN.Stops);
adj = zeros(nStops,nStops);
N = adj;

for i = 1:length(SF)
    o = MPTN.StopIdxTable([MPTN.StopIdxTable.stopIdBS]== SF(i).fromStopID).stopIdMS;
    d = MPTN.StopIdxTable([MPTN.StopIdxTable.stopIdBS]== SF(i).toStopID).stopIdMS;
    for hour = hourlist
        rowH = find(SF(i).hourlyAvg(:,1) == hour);
        N(o,d) = N(o,d) + SF(i).hourlyAvg(rowH,2);
    end
end
adj = round(0.5 * (length(hourlist)*60)./N);
adj(adj==Inf) = 0;

G = digraph(adj,'OmitSelfLoops');
G.Nodes.Names = {MPTN.Stops.name}';
G.Nodes.x = [MPTN.Stops.x]';
G.Nodes.y = [MPTN.Stops.y]';

end