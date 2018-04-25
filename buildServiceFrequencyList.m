function serviceFrequencyList = buildServiceFrequencyList(MPTN,SF,hourlist)

nLinks = length(MPTN.Links);
serviceFrequencyList = zeros(nLinks,1);
for i = 1:nLinks
    for childlink = MPTN.Links(i).childLinks
        oStop = MPTN.LinkIdxTable([MPTN.LinkIdxTable.linkIdBS]==childlink).oStopIdBS;
        dStop = MPTN.LinkIdxTable([MPTN.LinkIdxTable.linkIdBS]==childlink).dStopIdBS;
        
        row = find([SF.fromStopID] == oStop & [SF.toStopID] == dStop);
        for hour = hourlist
            idx = find(SF(row).hourlyAvg(:,1) == hour);
            serviceFrequencyList(i,1) = serviceFrequencyList(i,1) + SF(row).hourlyAvg(idx,2);
        end
    end
end
serviceFrequencyList = round(serviceFrequencyList./length(hourlist));    

end