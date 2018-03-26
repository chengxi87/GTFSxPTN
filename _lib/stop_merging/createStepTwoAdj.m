function A = createStepTwoAdj(Stops,LrUpdate,theta)

nStops = length(Stops);
A = zeros(nStops,nStops);
for i = 1:nStops-1
    for j = i+1:nStops
        % 1 = two stops from the same route
        % 0 = twos stops from different routes
        dr = ~isempty(intersect(LrUpdate{i},LrUpdate{j})); 
        dg = pdist2([Stops(i).x,Stops(i).y],[Stops(j).x,Stops(j).y]);      
        if ~dr & dg <= theta
            A(i,j) = 1;
            A(j,i) = 1;
        end   
    end
end

end