function gtfsTables = loadGTFS()

%% 
% This script loads raw gtfs data from the specified data path
% It only saves the columns (fields) that are necessary for later research
% purposes. Matlab 'Table' is used to store the data.
% --------------------
% Ding Luo, 2018/02/01

%%
disp('selec the gtfs data folder');
dataPath = uigetdir; % folder open
% file name making
prompt = 'file name of the result:';
dlg_title = 'GTFS file name input';
defaultans = {'gtfs_'};
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
gtfsFileName = answer{1};
% tables and necessary fields
gtfsTables = {...
    'calendar_dates',{'service_id','date','exception_type'};...
    'stop_times',{'trip_id','stop_id','stop_sequence','arrival_time','departure_time'};...
    'routes',{'route_id','agency_id','route_short_name','route_long_name','route_type'};...
    'shapes',{'shape_id','shape_pt_sequence','shape_pt_lat','shape_pt_lon'};...
    'stops',{'stop_id','stop_code','stop_name','stop_lat','stop_lon'};...
    'trips',{'route_id','service_id','trip_id','trip_headsign','trip_short_name','direction_id','shape_id'}};
% loop
for iTable = 1:length(gtfsTables)
    tableName = gtfsTables{iTable,1};
    neededFields = gtfsTables{iTable,2};   
    gtfsTables{iTable,3} = readOneTable(dataPath,tableName,neededFields);
    disp([tableName ' loaded...']);
end
% save data
% save(gtfsFileName,'gtfsTables','-v7.3');
% disp(['GTFS data has been loaded and saved as ' gtfsFileName]);

end


%% subfunction: readOneTable
function table = readOneTable(dataPath,tableName,neededFields)
path = [dataPath,'\',tableName,'.txt'];
table = readtable(path,'Delimiter',',');
% remove unnecessary fields
allClmNames = table.Properties.VariableNames;
for iName = allClmNames
    if ~ismember(iName,neededFields)
        table(:,iName) = [];
    end
end
end