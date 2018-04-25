clc;clear all;
str=pwd;
index_dir=findstr(pwd,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd,'\outputs']);
%% bottom-scale PTN
% -- Input specification
routeTypeList = [0]; % tram only
date = '20150304'; % select one day
load('denhaag_gtfs_201503.mat');
% -- Program
[BPTN.Routes,BPTN.Stops,BPTN.Links] = ...
    buildBottomScalePTN(gtfsTables,date,routeTypeList);
%% middle-scale PTN
% load the network
BPTN = load('dh_bottom_tramnetwork.mat'); % bottom scale
% --Inputs
theta = 0.0015;
exceptionList = ...
    {'Den Haag, Centraal Station','Den Haag, Centraal Station','merge';...
     'Den Haag, Centrum','Den Haag, Kalvermarkt-Stadhuis','merge';...
     'Den Haag, Station Laan van NOI','Den Haag, Laan van NOI','merge'};
% --Program
[MPTN.Stops,MPTN.Links,MPTN.Routes,MPTN.StopIdxTable,MPTN.LinkIdxTable] =...
    buildMiddleScalePTN(BPTN,theta,exceptionList);

%% top-scale PTN
MPTN = load('dh_middle_tramnetwork.mat');
[TPTN.Stops,TPTN.Links,TPTN.Routes,TPTN.StopIdxTable,TPTN.LinkIdxTable] = ...
    buildTopScalePTN(MPTN);

    
