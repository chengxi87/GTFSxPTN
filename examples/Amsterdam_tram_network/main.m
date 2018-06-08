%% Description
% To run this example, download the one-day GTFS data using the fllowing 
% link. Save the file on your disk and unzip it. Once you start the code,
% it will require you to direct to the unzipped GTFS foler.
%
% http://gtfs.ovapi.nl/gvb/gtfs-kv1gvb-20171114.zip

%% Path setting
str = pwd;
index_dir = findstr(str,'\');
str_temp = str(1:index_dir(end-1)-1);
addpath(str_temp);

%% Load GTFS data into MATLAB as tables
% Parameter setting
% -----------------
disp('selec the gtfs data folder');
gtfsFolderPath = uigetdir; % folder open
% Function
% --------
gtfsTables = loadGtfsFiles(gtfsFolderPath);

%% Build the Bottom-Scale Public Transport Network
% Note that this is a pretty time-comsuming process because the program has
% to go through all the trips of a day to create the final routes, stops and
% links.
%
% Parameter setting
% -----------------
routeTypeList = [0]; % tram only
date = '20171114';
% Function
% --------
[BPTN.Routes,BPTN.Stops,BPTN.Links] = buildBSPTN(gtfsTables,date,routeTypeList);

%% Plot the generated bottom-scale PTN
plotNetworkWithGeo(BPTN.Links,BPTN.Stops);