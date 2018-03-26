clc;clear all;
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd,'\outputs'])

% load the operation network
OPTN = load('denhaag_operation_tramnetwork.mat');

%%
stopMergingPara = 7;
[Stops,Links,Routes] = buildPlanningNetwork(OPTN,stopMergingPara);
    
