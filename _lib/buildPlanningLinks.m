function [Links,LinkIdxTable] = buildPlanningLinks(OPTN,StopIdxTable)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib']);

Links = [];
LinkIdxTable = [];
nLinks = 0;

for i = 1:length(OPTN.Links)
    planningOStopID = findPlanningStopID(OPTN.Links(i).oStop,StopIdxTable);
    planningDStopID = findPlanningStopID(OPTN.Links(i).dStop,StopIdxTable);
    LinkIdxTable(i).operationLinkID = OPTN.Links(i).ID;
    LinkIdxTable(i).operationOStopID = OPTN.Links(i).oStop;
    LinkIdxTable(i).operationDStopID = OPTN.Links(i).dStop;
    
    if isempty(Links)
        nLinks = nLinks + 1;
        linkID = nLinks;
        Links(linkID).ID = linkID;
        Links(linkID).oStop = planningOStopID;
        Links(linkID).dStop = planningDStopID;
        Links(linkID).childLinks = OPTN.Links(i).ID;   
        LinkIdxTable(i).planningLinkID = linkID;
        LinkIdxTable(i).planningOStopID = planningOStopID;
        LinkIdxTable(i).planningDStopID = planningDStopID;
        continue;
    end
    % find out whether this SuperLink already exists
    tmpIdx = find(planningOStopID == [Links.oStop] & ...
        planningDStopID == [Links.dStop]); 
    
    if isempty(tmpIdx)
        nLinks = nLinks + 1;
        linkID = nLinks;
        Links(linkID).ID = linkID;
        Links(linkID).oStop = planningOStopID;
        Links(linkID).dStop = planningDStopID;
        Links(linkID).childLinks = OPTN.Links(i).ID;
    else
        linkID = Links(tmpIdx).ID;
        Links(linkID).childLinks = [Links(linkID).childLinks,OPTN.Links(i).ID];
    end
    LinkIdxTable(i).planningLinkID = linkID;
    LinkIdxTable(i).planningOStopID = planningOStopID;
    LinkIdxTable(i).planningDStopID = planningDStopID;
end

end

%%
function planningStopID = findPlanningStopID(operationStopID,StopIdxTable)
idx = [StopIdxTable.operationStopID] == operationStopID;
planningStopID = StopIdxTable(idx).planningStopID;
end
