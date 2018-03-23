clc;clear all;close all;
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

%% Input specification
routeTypeList = [0]; % tram only
date = '20171114';
load('ams_gtfs_20171114.mat');

[Routes,Stops,Links] = buildOperationNetwork(gtfsTables,date,routeTypeList);

    
    
