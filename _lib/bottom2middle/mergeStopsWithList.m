function MergedStops = mergeStopsWithList(Stops,C)

MergedStops = [];
n = 0;
for i = 1:numel(C)
    n = n + 1;
    
    uniqueNames = unique({Stops(C{i}).name});
    MergedStops(n).name = char(join(uniqueNames,'/'));
    MergedStops(n).x = mean([Stops(C{i}).x]);
    MergedStops(n).y = mean([Stops(C{i}).y]);
    MergedStops(n).childStops = [Stops(C{i}).childStops];

end

end