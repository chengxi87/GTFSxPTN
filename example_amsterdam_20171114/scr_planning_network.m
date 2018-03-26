clc;clear all;close all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd '\outputs']);

% load the network
OPTN = load('ams_operation_tramnetwork.mat'); % operation PTN

theta = 0.0017;
[Stops,Links,Routes,StopIdxTable,LinkIdxTable] = buildPlanningNetwork(OPTN,theta);




