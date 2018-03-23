function Neighbors = findClosestStopFromOtherRoute(Stops)

Neighbors = [];
k = 0;
for i = 1:length(Stops)-1
    minDist = inf;
    finalJ = NaN;
    for j = i+1:length(Stops)
        % avoid stop pairs from the same route
        if ~isempty(intersect(Stops(i).routeIDs,Stops(j).routeIDs))
            continue;
        end
        
        tmpDist = pdist2(Stops(i).coord,Stops(j).coord);
        if tmpDist < minDist
            minDist = tmpDist;
            finalJ = j;
        end
    end
    if ~isnan(finalJ)
        k = k + 1;
        Neighbors(k).firstName = Stops(i).name;
        Neighbors(k).secondName = Stops(finalJ).name;
        Neighbors(k).firstCoord = Stops(i).coord;
        Neighbors(k).secondCoord = Stops(finalJ).coord;
        Neighbors(k).dist = minDist;
    end
end
[~,idx] = sort([Neighbors.dist]);
Neighbors = Neighbors(idx);

end