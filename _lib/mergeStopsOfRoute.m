function MergedStopsOfRoute = mergeStopsOfRoute(routeID,OPTN)

% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib']);

rows = find(strcmp(routeID,{OPTN.Routes.routeID}));
tmp = [];
for row = rows
    tmp = [tmp OPTN.Routes(row).stops];
end
tmp = unique(tmp)';
val = {};
for k = 1:size(tmp,1)
    val{k,1} = tmp(k);
    [val{k,2},val{k,3}] = getStopInfo(OPTN.Stops,tmp(k,1));
end

uniqueStops = unique(val(:,2));
MergedStopsOfRoute = [];
n = 0;
for j = 1:size(uniqueStops,1)
    idx = find(strcmp(uniqueStops{j,1},val(:,2)));
    n = n + 1;
    MergedStopsOfRoute(n).name = uniqueStops{j,1};
    MergedStopsOfRoute(n).coord = mean(cell2mat(val(idx,3)),1);
    MergedStopsOfRoute(n).x = MergedStopsOfRoute(n).coord(1);
    MergedStopsOfRoute(n).y = MergedStopsOfRoute(n).coord(2);
    MergedStopsOfRoute(n).childStops = sort(cell2mat(val(idx,1))');
    MergedStopsOfRoute(n).routeIDs = routeID;
    MergedStopsOfRoute(n).idx = strcat(MergedStopsOfRoute(n).name,',',...
        num2str(MergedStopsOfRoute(n).childStops));
    
end

end