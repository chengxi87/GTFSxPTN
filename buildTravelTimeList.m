function travelTimeList = buildTravelTimeList(PPTN,LTT,hourlist)

nLinks = length(PPTN.Links);
travelTimeList = zeros(nLinks,1);
for i = 1:length(PPTN.Links)
    % travel time
    childLinks = PPTN.Links(i).childLinks;
    avgTravelTime = computeAvgTravelTime(childLinks,PPTN.LinkIdxTable,LTT,hourlist);
    travelTimeList(i,1) = avgTravelTime;
end
end

%%
function result = computeAvgTravelTime(childLinks,LinkIdxTable,LTT,hourlist)

t = [];
for childLinkID = childLinks
    operationOStopID = LinkIdxTable([LinkIdxTable.operationLinkID]==childLinkID).operationOStopID;
    operationDStopID = LinkIdxTable([LinkIdxTable.operationLinkID]==childLinkID).operationDStopID;
    
    row = find([LTT.oStop] == operationOStopID & [LTT.dStop] == operationDStopID);
    for hour = hourlist
        rowH = find(LTT(row).hourlyAvg(:,1) == hour);
        t = [t,LTT(row).hourlyAvg(rowH,2)];
    end
end
result = round(mean(t));
    
end