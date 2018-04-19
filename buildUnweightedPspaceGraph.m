function [G,adj] = buildUnweightedPspaceGraph(PPTN)

nStops = length(PPTN.Stops);
adj = zeros(nStops,nStops);

% generate adj for the P space graph
for iRoute = 1:length(PPTN.Routes)
    stops = PPTN.Routes(iRoute).stops;
    for i = 1:length(stops)
        for j = i+1:length(stops)
            r = stops(i);
            c = stops(j);
            adj(r,c) = 1;
        end
    end
end

G = digraph(adj,'OmitSelfLoops');
G.Nodes.Names = {PPTN.Stops.name}';
G.Nodes.x = [PPTN.Stops.x]';
G.Nodes.y = [PPTN.Stops.y]';

end