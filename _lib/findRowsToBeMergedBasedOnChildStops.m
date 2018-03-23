function mergingList = findRowsToBeMergedBasedOnChildStops(TmpStops)

uniqueStopNames = findUniqueStopNames(TmpStops);
% only check stops with the name repeated twice
idxList = find(cell2mat(uniqueStopNames(:,2)) >= 2);
mergingList = [];
for idx = idxList'
    curStopName = uniqueStopNames{idx,1};
    rowList = find(strcmp(curStopName,{TmpStops.name}));
    mergingList = [mergingList;findFinalMergeListOfOneStop(rowList,TmpStops)];
end

end


%%
function finalMergeListOfOneStop = findFinalMergeListOfOneStop(rowList,TmpStops)
% this merging is an iterative process
tmpMergeList = [];
% first merging
n = 0;
for i = 1:length(rowList) - 1
    rowA = rowList(i);
    for j = i+1:length(rowList)
        rowB = rowList(j);
        if ~isempty(intersect(TmpStops(rowA).childStops,TmpStops(rowB).childStops))
            n = n + 1;
            tmpMergeList{n,1} = sort([rowA, rowB]);
        end
    end
end
% one more update of the mergeList
finalMergeListOfOneStop = [];
if n > 1
    m = 0;
    for i = 1:n-1
        for j = i+1:n
            if ~isempty(intersect(tmpMergeList{i,1},tmpMergeList{j,1}))
                m = m + 1;
                val = unique([tmpMergeList{i,1},tmpMergeList{j,1}]);
                finalMergeListOfOneStop{m,1} = val;       
            end
        end
    end
    
    % remove duplicates
    ind = true(1,numel(finalMergeListOfOneStop)); %// true indicates non-duplicate. Initiallization
    for ii = 1:numel(finalMergeListOfOneStop)-1
        for jj = ii+1:numel(finalMergeListOfOneStop)
            if isequal(finalMergeListOfOneStop{ii}, finalMergeListOfOneStop{jj})
                ind(jj) = false; %// mark as duplicate
            end
        end
    end
    finalMergeListOfOneStop = finalMergeListOfOneStop(ind);

else
    finalMergeListOfOneStop = tmpMergeList;
end

end
