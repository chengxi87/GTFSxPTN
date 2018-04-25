function [G,adj] = buildWeightedLSpaceGraphTopScale(TPTN,MPTN,LTT,SF,hourlist)

travelTimeListMS = buildTravelTimeList(MPTN,LTT,hourlist);
% travel time as 'COST'
travelTimeListTS = [];
n = 0;
for i = 1:length(TPTN.Links)
    if TPTN.Links(i).oStop ~= TPTN.Links(i).dStop % no self-loop
        n = n + 1;
        travelTimeListTS(n,1) = TPTN.Links(i).oStop;
        travelTimeListTS(n,2) = TPTN.Links(i).dStop; 
        travelTimeListTS(n,3) = 0;
        for childLink = TPTN.Links(i).childLinks
            travelTimeListTS(n,3) = travelTimeListTS(n,3) + travelTimeListMS(childLink);
        end
    end
end

% service frequency as 'importance'
serviceFrequencyTS = [];
n = 0;
for i = 1:length(TPTN.Links)
    oStop = TPTN.Links(i).oStop;
    dStop = TPTN.Links(i).dStop;
    if oStop ~= dStop
        n = n + 1;
        serviceFrequencyTS(n,1) = oStop;
        serviceFrequencyTS(n,2) = dStop;
        serviceFrequencyTS(n,3) = getServiceFrequencyTopScale(oStop,dStop,SF,TPTN,hourlist);   
    end
end

[G,adj] = buildUnweightedLspaceGraph(TPTN); % no self loop
G.Edges.TravelTime = zeros(size(G.Edges,1),1);
G.Edges.ServiceFrequency = zeros(size(G.Edges,1),1);
for i = 1:size(G.Edges)
    oNode = G.Edges.EndNodes(i,1);
    dNode = G.Edges.EndNodes(i,2);
    G.Edges.TravelTime(i) = travelTimeListTS((travelTimeListTS(:,1) == oNode &...
        travelTimeListTS(:,2) == dNode),3);
    G.Edges.ServiceFrequency(i) = serviceFrequencyTS((serviceFrequencyTS(:,1) == oNode &...
        serviceFrequencyTS(:,2) == dNode),3);   
end

end