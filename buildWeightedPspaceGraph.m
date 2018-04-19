function [G,adj] = buildWeightedPspaceGraph(PPTN,SF,hourlist)

nStops = length(PPTN.Stops);
adj = zeros(nStops,nStops);
N = adj;

for i = 1:length(SF)
    o = PPTN.StopIdxTable([PPTN.StopIdxTable.operationStopID]== SF(i).fromStopID).planningStopID;
    d = PPTN.StopIdxTable([PPTN.StopIdxTable.operationStopID]== SF(i).toStopID).planningStopID;
    for hour = hourlist
        rowH = find(SF(i).hourlyAvg(:,1) == hour);
        N(o,d) = N(o,d) + SF(i).hourlyAvg(rowH,2);
    end
end
adj = round(0.5 * (length(hourlist)*60)./N);
adj(adj==Inf) = 0;

G = digraph(adj,'OmitSelfLoops');
G.Nodes.Names = {PPTN.Stops.name}';
G.Nodes.x = [PPTN.Stops.x]';
G.Nodes.y = [PPTN.Stops.y]';

end