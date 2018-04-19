function serviceFrequencyList = buildServiceFrequencyList(PPTN,SF,hourlist)

nLinks = length(PPTN.Links);
serviceFrequencyList = zeros(nLinks,1);
for i = 1:nLinks
    for childlink = PPTN.Links(i).childLinks
        oStop = PPTN.LinkIdxTable([PPTN.LinkIdxTable.operationLinkID]==childlink).operationOStopID;
        dStop = PPTN.LinkIdxTable([PPTN.LinkIdxTable.operationLinkID]==childlink).operationDStopID;
        
        row = find([SF.fromStopID] == oStop & [SF.toStopID] == dStop);
        for hour = hourlist
            idx = find(SF(row).hourlyAvg(:,1) == hour);
            serviceFrequencyList(i,1) = serviceFrequencyList(i,1) + SF(row).hourlyAvg(idx,2);
        end
    end
end
serviceFrequencyList = round(serviceFrequencyList./length(hourlist));    

end