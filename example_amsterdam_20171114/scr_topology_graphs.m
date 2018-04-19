clc;clear all;close all;
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd,'\outputs']);

% load data
PPTN = load('ams_planning_tramnetwork.mat'); % planning PTN
load('ams_link_travel_times.mat');
load('ams_service_frequency.mat');

%% unweighted L-space graph
% [G,adj] = buildUnweightedLspaceGraph(PPTN);

%% weighted L-space graph
% hourlist = [7,8,9];
% [G,adj] = buildWeightedLspaceGraph(PPTN,LTT,hourlist);

%% unweighted P-space graph
% [G,adj] = buildUnweightedPspaceGraph(PPTN);

%% weighted P-space graph
hourlist = [7,8,9];
[G,adj] = buildWeightedPspaceGraph(PPTN,SF,hourlist);


