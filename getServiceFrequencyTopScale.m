function serviceFrequency = getServiceFrequencyTopScale(oStop,dStop,SF,TPTN,hourlist)

oChildStops = TPTN.Stops(oStop).childStops;
dChildStops = TPTN.Stops(dStop).childStops;

serviceFrequency = 0;
for iStop = oChildStops
    for jStop = dChildStops
        idx = find([SF.fromStopID] == iStop & [SF.toStopID] == jStop);
        if ~isempty(idx)
            for hour = hourlist
                rowH = find(SF(idx).hourlyAvg(:,1) == hour);
                serviceFrequency = serviceFrequency + SF(idx).hourlyAvg(rowH,2);
            end
        end
    end
end
serviceFrequency = ceil(serviceFrequency/length(hourlist));


end