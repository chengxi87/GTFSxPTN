clc;clear all;close all;
% add paths
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([str_temp,'\_lib\ptn_analysis']);
addpath([str_temp,'\example_amsterdam_20171114\outputs']);
% load data
BPTN = load('ams_bottom_tramnetwork_revised.mat');
MPTN = load('ams_middle_tramnetwork.mat');
TPTN = load('ams_top_tramnetwork.mat');
load('ams_link_travel_times.mat'); % LTT = Link Travel Times
load('ams_service_frequency.mat'); % SF = Service Frequency
% colormap
load('ptnodes.mat');
colormapmat = ptnodes;

hourlist = [7,8,9];
% L-space graph
[GtL,~] = buildWeightedLSpaceGraphTopScale(TPTN,MPTN,LTT,SF,hourlist);
GtP = buildWeightedPSpaceGraphTopScale(TPTN,SF,hourlist);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% indegree, unweighted L-space
GtL.Nodes.idc = centrality(GtL,'indegree');
data(:,1) = scaling(GtL.Nodes.idc,'sum');
% indegree, weighted L-space by service frequency
GtL.Nodes.widc = centrality(GtL, 'indegree','Importance', GtL.Edges.ServiceFrequency); 
data(:,2) = scaling(GtL.Nodes.widc,'sum');
plotNodeColormap(TPTN.Stops,TPTN.Links,data,1,'in-degree (unweighted L-space)',colormapmat);
plotNodeColormap(TPTN.Stops,TPTN.Links,data,2,'in-degree (weighted L-space)',colormapmat);
% indegree comparison
cmpdata = (scaling(GtL.Nodes.widc,'sum') - scaling(GtL.Nodes.idc,'sum'));
plotCmpColormap(TPTN.Stops,TPTN.Links,cmpdata,'comparison (weighted - unweighted)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% betweenness, unweighted L-space, middle scale
GtL.Nodes.bc = centrality(GtL, 'betweenness'); 
data(:,1) = scaling(GtL.Nodes.bc,'sum');
% betweenness, weighted L-space by link travel time, middle scale
GtL.Nodes.wbc = centrality(GtL, 'betweenness','Cost', GtL.Edges.TravelTime); 
data(:,2) = scaling(GtL.Nodes.wbc,'sum');
plotNodeColormap(TPTN.Stops,TPTN.Links,data,1,'betweenness (unweighted L-space)',colormapmat);
plotNodeColormap(TPTN.Stops,TPTN.Links,data,2,'betweenness (weighted L-space)',colormapmat);
% betweenness comparison, middle scale
cmpdata = (scaling(GtL.Nodes.wbc,'sum') - scaling(GtL.Nodes.bc,'sum'));
plotCmpColormap(TPTN.Stops,TPTN.Links,cmpdata,'comparison (weighted - unweighted)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% P space for middle scale
% betweenness, unweighted P-space, middle scale
GtP.Nodes.bc = centrality(GtP, 'betweenness'); 
data(:,1) = scaling(GtP.Nodes.bc,'sum');
% betweenness, weighted P-space by headway, middle scale
GtP.Nodes.wbc = centrality(GtP, 'betweenness','Cost', GtP.Edges.Headway); 
data(:,2) = scaling(GtP.Nodes.wbc,'sum');

plotNodeColormap(TPTN.Stops,TPTN.Links,data,1,'betweenness (unweighted P-space)',colormapmat);
plotNodeColormap(TPTN.Stops,TPTN.Links,data,2,'betweenness (weighted P-space)',colormapmat);
% betweenness comparison, middle scale
cmpdata = (scaling(GtP.Nodes.wbc,'sum') - scaling(GtP.Nodes.bc,'sum'));
plotCmpColormap(TPTN.Stops,TPTN.Links,cmpdata,'comparison (weighted - unweighted)');



