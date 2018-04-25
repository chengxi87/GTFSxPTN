clc;clear all;close all;
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd '\outputs']);
%% Bottom-scale PTN
%--- Inputs
routeTypeList = [0]; % tram only
date = '20171114';
load('ams_gtfs_20171114.mat');
%--- Method
[BPTN.Routes,BPTN.Stops,BPTN.Links] = buildBottomScalePTN(gtfsTables,date,routeTypeList);
%% Middle-scale PTN  
% load the network
BPTN = load('ams_bottom_tramnetwork_revised.mat'); % bottom scale
%--- Inputs
theta = 0.0015;
exceptionList = ...
    {'Amsterdam, Centraal Station','Amsterdam, Centraal Station','merged';...
     'Amsterdam, Lod. v. Deysselstraat','Amsterdam, Slotermeerlaan','separate'};
%--- Method
[MPTN.Stops,MPTN.Links,MPTN.Routes,MPTN.StopIdxTable,MPTN.LinkIdxTable] = ...
    buildMiddleScalePTN(BPTN,theta,exceptionList);
plotNetworkNoGeo(MPTN.Links,MPTN.Stops,0);
%% Top-scale PTN
MPTN = load('ams_middle_tramnetwork.mat');
[TPTN.Stops,TPTN.Links,TPTN.Routes,TPTN.StopIdxTable,TPTN.LinkIdxTable] = ...
    buildTopScalePTN(MPTN);