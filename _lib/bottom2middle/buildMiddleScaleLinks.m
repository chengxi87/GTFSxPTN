function [Links,LinkIdxTable] = buildMiddleScaleLinks(BPTN,StopIdxTable)
% add path to the _lib
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath([str_temp,'\_lib\bottom2middle']);

Links = [];
LinkIdxTable = [];
nLinks = 0;

for i = 1:length(BPTN.Links)
    oStopIdMS = findMiddleScaleStopID(BPTN.Links(i).oStop,StopIdxTable);
    dStopIdMS = findMiddleScaleStopID(BPTN.Links(i).dStop,StopIdxTable);
    LinkIdxTable(i).linkIdBS = BPTN.Links(i).ID;
    LinkIdxTable(i).oStopIdBS = BPTN.Links(i).oStop;
    LinkIdxTable(i).dStopIdBS = BPTN.Links(i).dStop;
    
    if isempty(Links)
        nLinks = nLinks + 1;
        linkID = nLinks;
        Links(linkID).ID = linkID;
        Links(linkID).oStop = oStopIdMS;
        Links(linkID).dStop = dStopIdMS;
        Links(linkID).childLinks = BPTN.Links(i).ID;   
        LinkIdxTable(i).linkIdMS = linkID;
        LinkIdxTable(i).oStopIdMS = oStopIdMS;
        LinkIdxTable(i).dStopIdMS = dStopIdMS;
        continue;
    end
    % find out whether this SuperLink already exists
    tmpIdx = find(oStopIdMS == [Links.oStop] & ...
        dStopIdMS == [Links.dStop]); 
    
    if isempty(tmpIdx)
        nLinks = nLinks + 1;
        linkID = nLinks;
        Links(linkID).ID = linkID;
        Links(linkID).oStop = oStopIdMS;
        Links(linkID).dStop = dStopIdMS;
        Links(linkID).childLinks = BPTN.Links(i).ID;
    else
        linkID = Links(tmpIdx).ID;
        Links(linkID).childLinks = [Links(linkID).childLinks,BPTN.Links(i).ID];
    end
    LinkIdxTable(i).linkIdMS = linkID;
    LinkIdxTable(i).oStopIdMS = oStopIdMS;
    LinkIdxTable(i).dStopIdMS = dStopIdMS;
end

end

%%
function stopIdMS = findMiddleScaleStopID(stopIdBS,StopIdxTable)
idx = [StopIdxTable.stopIdBS] == stopIdBS;
stopIdMS = StopIdxTable(idx).stopIdMS;
end
