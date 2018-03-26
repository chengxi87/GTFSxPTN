function A = createStepOneAdj(Stops,Ln,Lr)

nStops = length(Stops);
A = zeros(nStops,nStops);
for i = 1:nStops-1
    for j = i+1:nStops
        dn = strcmp(Ln{i,1},Ln{j,1});       
        dr = ~isempty(intersect(convertFormat(Lr{i,1}),convertFormat(Lr{j,1})));
        if dn & dr
            A(i,j) = 1;
            A(j,i) = 1;
        end
    end
end

end


function result = convertFormat(routeIDs)

if ischar(routeIDs)
    result = {routeIDs};
else
    result = routeIDs;
end

end