function [fullStopSequence,finalTripDes,finalShapeID] = ...
    findFullStopSequence(dirID,tripList,stoptimes)

subTripList = tripList(cell2mat(tripList(:,4)) == dirID,:);
% combine destination and shape to find unique trips
tmpStrList = [];
for i = 1:size(subTripList,1)
    idx = find(strcmp(subTripList{i,1},stoptimes(:,1)));
    subTripList{i,6} = length(idx); % number of stops of this trip
    tmpStrList{i,1} = [char(subTripList{i,2}),',',...
                       int2str(subTripList{i,5}),',',...
                       int2str(subTripList{i,end})];
end

[uniqueTrips,IA,IC] = unique(tmpStrList);

nTotalStops = 0;
finalTripStopSeq = [];
finalTripDes = [];
finalShapeID = [];

for k = 1:length(IA)
    rowID = IA(k);
    curTripID = subTripList{rowID,1};
    curTripDest = char(subTripList{rowID,2});
    curTripShape = subTripList{rowID,5};
    
    idxList = find(strcmp(curTripID,{stoptimes{:,1}}));
    curTripStopSeq = stoptimes(idxList,:);
    % sort curTrip based on the stop sequence
    [~, idx] = sort(cell2mat(curTripStopSeq(:,2)));
    curTripStopSeq = curTripStopSeq(idx,2:3);
    
    nCurStops = size(curTripStopSeq,1);
    if nCurStops > nTotalStops
        nTotalStops = nCurStops;
        finalTripStopSeq = curTripStopSeq;
        finalTripDes = curTripDest;
        finalShapeID = curTripShape;
    end
end

fullStopSequence = finalTripStopSeq(:,2);

end