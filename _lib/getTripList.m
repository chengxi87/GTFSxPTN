% obtain a tripList from the "trips" table with specified routeID and date
function tripList = getTripList(tripsTable,routeID,serviceIdList)

tripList = []; % initialize
idxList = find(strcmp(routeID,tripsTable.route_id));
for idx = idxList'
    curServiceID = tripsTable.service_id(idx);
    if ismember(curServiceID,serviceIdList)
        tmpLine = {tripsTable.trip_id(idx),...
            tripsTable.trip_headsign(idx),...
            tripsTable.trip_short_name(idx),...
            tripsTable.direction_id(idx),...
            tripsTable.shape_id(idx)};
        tripList = [tripList; tmpLine];
    end
end % end for

end