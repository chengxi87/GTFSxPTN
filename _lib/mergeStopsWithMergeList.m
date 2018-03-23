function Stops = mergeStopsWithMergeList(mergeList,Stops)

n = length(Stops);
idx = [];
for i = 1:numel(mergeList)
    rowNums = mergeList{i,1};
    uniqueNames = unique({Stops(rowNums).name});
    n = n + 1;
    Stops(n).name = char(join(uniqueNames,'/'));
    Stops(n).x = mean([Stops(rowNums).x]);
    Stops(n).y = mean([Stops(rowNums).y]);
    Stops(n).coord = [Stops(n).x,Stops(n).y];
    Stops(n).childStops = unique([Stops(rowNums).childStops]);
    Stops(n).routeIDs = [Stops(rowNums).routeIDs];
    idx = [idx,rowNums];
end
Stops(idx) = [];

end