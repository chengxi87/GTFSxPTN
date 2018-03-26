function stopsRouteLabelSet = createStopsRouteLabelSet(Stops,Routes)

nStops = length(Stops);
stopsRouteLabelSet = cell(nStops,1);
for i = 1:length(Routes)
    routeID = Routes(i).routeID;
    stops = Routes(i).stops;
    for stop = stops
        rowNum = find([Stops.ID] == stop);
        if isempty(stopsRouteLabelSet{rowNum,1})
            stopsRouteLabelSet(rowNum,1) = {routeID};
        else
            stopsRouteLabelSet{rowNum,1} = unique([stopsRouteLabelSet{rowNum, 1},{routeID}]);
        end
    end
end

end