clc;clear all;close all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
% load the network
OPTN = load('ams_operation_tramnetwork.mat'); % operation PTN

%% Stops



% distThreshold = 0.0028;
% [Stops,StopIdxTable] = mergeOperationStops4PlanningStops(OPTN,distThreshold);

% [Stops,StopIdxTable] = buildPlanningStops(OPTN,distThreshold);
% %% Links
% % load('planningStops.mat');
% [Links,LinkIdxTable] = buildPlanningLinks(OPTN,StopIdxTable);
% %% Routes
% Routes = buildPlanningRoutes(OPTN,StopIdxTable,LinkIdxTable);

