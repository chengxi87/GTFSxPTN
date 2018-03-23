function [G,adj] = buildUnweightedPspaceGraph(SuperStops,SuperRoutes)

nStops = length(SuperStops);
adj = zeros(nStops,nStops);

% generate adj for the P space graph
for iRoute = 1:length(SuperRoutes)
    superStops = SuperRoutes(iRoute).superStops;
    for i = 1:length(superStops)
        for j = i+1:length(superStops)
            r = superStops(i);
            c = superStops(j);
            adj(r,c) = 1;
        end
    end
end

G = digraph(adj,'OmitSelfLoops');
G.Nodes.Names = {SuperStops.name}';
G.Nodes.x = [SuperStops.x]';
G.Nodes.y = [SuperStops.y]';

end