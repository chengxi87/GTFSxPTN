clc;clear all;close all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd '\outputs']);

% load the network
BPTN = load('ams_bottom_tramnetwork.mat'); % bottom scale

theta = 0.0015;
[Stops,Links,Routes,StopIdxTable,LinkIdxTable] = buildMiddleScalePTN(BPTN,theta);






