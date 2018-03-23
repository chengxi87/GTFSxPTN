% select all service ids of the specified date
function serviceIdList = getServiceIdList(calendardatesTable,date)
% all service_ids of the specified date
idx = (calendardatesTable.date == str2num(date));
serviceIdList = calendardatesTable.service_id(idx);
end