clc;clear all;close all;
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

% load data
PPTN = load('ams_planning_tramnetwork.mat'); % planning PTN
OPTN = load('ams_operations_tramnetwork.mat');
load('ams_link_travel_times.mat');

%%
[G,adj] = buildUnweightedLspaceGraph(PPTN);
plotNetworkNoGeo(PPTN.Links,PPTN.Stops);
figure;
plotNetworkNoGeo(OPTN.Links,OPTN.Stops);
%%
% [G,adj] = buildWeightedLspaceGraph(PPTN,LTT);


