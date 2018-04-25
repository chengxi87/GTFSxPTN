function travelTimeList = buildTravelTimeList(PTN,LTT,hourlist)

nLinks = length(PTN.Links);
travelTimeList = zeros(nLinks,1);
for i = 1:length(PTN.Links)
    % travel time
    childLinks = PTN.Links(i).childLinks;
    avgTravelTime = computeAvgTravelTime(childLinks,PTN.LinkIdxTable,LTT,hourlist);
    travelTimeList(i,1) = avgTravelTime;
end
end

%%
function result = computeAvgTravelTime(childLinks,LinkIdxTable,LTT,hourlist)

t = [];
for childLinkID = childLinks
    oStopIdBS = LinkIdxTable([LinkIdxTable.linkIdBS]==childLinkID).oStopIdBS;
    dStopIdBS = LinkIdxTable([LinkIdxTable.linkIdBS]==childLinkID).dStopIdBS;
    
    row = find([LTT.oStop] == oStopIdBS & [LTT.dStop] == dStopIdBS);
    for hour = hourlist
        rowH = find(LTT(row).hourlyAvg(:,1) == hour);
        t = [t,LTT(row).hourlyAvg(rowH,2)];
    end
end
result = round(mean(t));
    
end