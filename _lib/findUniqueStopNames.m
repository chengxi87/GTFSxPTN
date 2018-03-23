function uniqueStopNames = findUniqueStopNames(Stops)

uniqueStopNames = unique({Stops.name})';
for i = 1:size(uniqueStopNames,1)
    name = uniqueStopNames{i,1};
    idx = find(strcmp(name,{Stops.name}));
    uniqueStopNames{i,2} = length(idx);
end
[~, idx] = sort(cell2mat(uniqueStopNames(:,2)),'descend');
uniqueStopNames = uniqueStopNames(idx,:);


end