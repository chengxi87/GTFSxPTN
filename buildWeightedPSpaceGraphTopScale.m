function G = buildWeightedPSpaceGraphTopScale(TPTN,SF,hourlist)

[G,~] = buildUnweightedPspaceGraph(TPTN);

G.Edges.Headway = zeros(size(G.Edges,1),1);
for i = 1:size(G.Edges,1)
    oStop = G.Edges.EndNodes(i,1);
    dStop = G.Edges.EndNodes(i,2); 
    N = getServiceFrequencyTopScale(oStop,dStop,SF,TPTN,hourlist);
    G.Edges.Headway(i) = round(0.5 * (length(hourlist)*60)./N);
end

end