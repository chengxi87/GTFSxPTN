clc;clear all;
%% path 
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end-1)-1);
addpath(str_temp);

%% load GTFS data
gtfsFolderPath = [pwd, '\gtfs_data'];
gtfsTables = loadGtfsFiles(gtfsFolderPath);
%% BSPTN building
routeTypeList = [0,1,3]; 
date = '20180320';
% generate the bottom-scale ptn
[BSPTN.Routes,BSPTN.Stops,BSPTN.Links] = buildBSPTN(gtfsTables,date,routeTypeList);