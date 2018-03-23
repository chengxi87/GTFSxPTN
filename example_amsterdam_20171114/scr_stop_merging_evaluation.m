clc;clear all;close all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
% load the network
OPTN = load('ams_operation_tramnetwork.mat'); % operation PTN

%% Stops
plotSwtich = 1;
alpha = 8; % stop clusters within top percentile of distance will be merged 
[Stops,StopIdxTable] = mergeOperationStops(OPTN,alpha,1);

%% Links
[Links,LinkIdxTable] = buildPlanningLinks(OPTN,StopIdxTable);
%% Routes
Routes = buildPlanningRoutes(OPTN,StopIdxTable,LinkIdxTable);

