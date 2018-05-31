function [G,adj] = buildUnweightedPGraph(PTN)

nStops = length(PTN.Stops);
adj = zeros(nStops,nStops);

% generate adj for the P space graph
for iRoute = 1:length(PTN.Routes)
    stops = PTN.Routes(iRoute).stops;
    for i = 1:length(stops)
        for j = i+1:length(stops)
            r = stops(i);
            c = stops(j);
            adj(r,c) = 1;
        end
    end
end

G = digraph(adj,'OmitSelfLoops');
G.Nodes.Names = {PTN.Stops.name}';
G.Nodes.x = [PTN.Stops.x]';
G.Nodes.y = [PTN.Stops.y]';

end