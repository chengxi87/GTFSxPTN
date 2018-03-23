function TmpStops = doIntraRouteStopMerging(OPTN)

TmpStops = struct('name',[],'coord',[],'x',[],'y',[],...
    'childStops',[],'routeIDs',[],'idx',[]);
uniqueRouteIDs = unique({OPTN.Routes.routeID});
for routeID = uniqueRouteIDs
    % merge stops with the same name from this route ID
    MergedStopsOfRoute = mergeStopsOfRoute(routeID,OPTN);
    % add these stops to the temporary stop set and avoid completely
    % identical stops
    for i = 1:length(MergedStopsOfRoute)
        idx = find(strcmp(MergedStopsOfRoute(i).name,{TmpStops.name}) & ...
            strcmp(MergedStopsOfRoute(i).idx,{TmpStops.idx}));
        if isempty(idx)
            TmpStops = [TmpStops MergedStopsOfRoute(i)];
        else
            TmpStops(idx).routeIDs = [TmpStops(idx).routeIDs MergedStopsOfRoute(i).routeIDs];
        end  
    end
end
TmpStops(1) = [];
TmpStops = rmfield(TmpStops,'idx');
end