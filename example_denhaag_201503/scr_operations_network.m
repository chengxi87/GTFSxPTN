clc;clear all;
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd,'\outputs'])

%% Input specification
routeTypeList = [0]; % tram only
date = '20150304'; % select one day
load('denhaag_gtfs_201503.mat');

[Routes,Stops,Links] = buildOperationNetwork(gtfsTables,date,routeTypeList);

%% visualize the generated OPTN
lh = plotNetworkWithGeo(Links,Stops);
    
