function finalMergingList = determineFinalMergingList(idxList,TmpStops,DistList)

% step 1: get stop pairs
rowsToBeMerged = [];
t = 0;
for idx = idxList
    t = t + 1;
    m = find(strcmp(DistList(idx).firstName,{TmpStops.name}) & ...
        DistList(idx).firstCoord(1) == [TmpStops.x] & ...
        DistList(idx).firstCoord(2) == [TmpStops.y]);
    n = find(strcmp(DistList(idx).secondName,{TmpStops.name}) & ...
        DistList(idx).secondCoord(1) == [TmpStops.x] & ...
        DistList(idx).secondCoord(2) == [TmpStops.y]);
    rowsToBeMerged(t,1:2) = [m,n];
end
% step 2: form stop clusters
finalMergingList = formStopClusters(rowsToBeMerged);
end

%%
function w = formStopClusters(rowsToBeMerged)

w = {};
v = 0;
for i = 1:size(rowsToBeMerged,1)
    if isempty(w)
        v = v + 1;
        w{v,1} = rowsToBeMerged(i,:);
        continue;
    else
        p = 0;
        for k = 1:size(w,1)
            if ~isempty(intersect(w{k},rowsToBeMerged(i,:)))
                w{k} = unique([w{k},rowsToBeMerged(i,:)]);
                continue;
            else
                p = p + 1;
            end
        end
        if p == size(w,1)
            v = v + 1;
            w{v,1} = rowsToBeMerged(i,:);
        end
        
    end
    
end
end