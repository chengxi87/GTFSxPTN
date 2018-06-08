clc;clear all;close all;
% add paths
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end-1)-1);
addpath(str_temp);
addpath([str_temp,'\_lib\ptn_analysis']);
addpath([str_temp,'\examples\Amsterdam_tram_20171114\outputs']);
% load data
BPTN = load('ams_bottom_tramnetwork_revised.mat');
MPTN = load('ams_middle_tramnetwork.mat');
TPTN = load('ams_top_tramnetwork.mat');
load('ams_link_travel_times.mat'); % LTT = Link Travel Times
load('ams_service_frequency.mat'); % SF = Service Frequency
% colormap
load('ptnodes.mat');
colormapmat = ptnodes;
%% plot bottom tram network of Amserdam
figure;
plotNetworkWithGeo(BPTN.Links,BPTN.Stops);
%% plot middle tram network of Amsterdam
figure;
textOn = 0;
plotNetworkNoGeo(MPTN.Links,MPTN.Stops,textOn);
%% plot middle tram network of Amsterdam
figure;
textOn = 0;
plotNetworkNoGeo(TPTN.Links,TPTN.Stops,textOn);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% L space for middle scale
hourlist = [7,8,9];
[GmL,~] = buildWeightedLGraphMS(MPTN,LTT,SF,hourlist);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% test 'hub' and 'authorities'
GmL.Nodes.plainhub = centrality(GmL,'hubs');
data = GmL.Nodes.plainhub;
plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'hub-plain',colormapmat);

GmL.Nodes.plainaut = centrality(GmL,'authorities');
data = GmL.Nodes.plainaut;
plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'aut-plain',colormapmat);

GmL.Nodes.hub = centrality(GmL,'hubs','Importance',GmL.Edges.ServiceFrequency);
data = GmL.Nodes.hub;
plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'hub',colormapmat);

GmL.Nodes.aut = centrality(GmL,'authorities','Importance',GmL.Edges.ServiceFrequency);
data = GmL.Nodes.aut;
plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'authorities',colormapmat);

%% indegree, unweighted L-space
GmL.Nodes.idc = centrality(GmL,'indegree');
data(:,1) = scaling(GmL.Nodes.idc,'sum');
% indegree, weighted L-space by service frequency
GmL.Nodes.widc = centrality(GmL, 'indegree','Importance', GmL.Edges.ServiceFrequency); 
data(:,2) = scaling(GmL.Nodes.widc,'sum');
plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'in-degree (unweighted L-space)',colormapmat);
plotNodeColormap(MPTN.Stops,MPTN.Links,data,2,'in-degree (weighted L-space)',colormapmat);
% indegree comparison
cmpdata = (scaling(GmL.Nodes.widc,'sum') - scaling(GmL.Nodes.idc,'sum'));
plotCmpColormap(MPTN.Stops,MPTN.Links,cmpdata,'comparison (weighted - unweighted)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% betweenness, unweighted L-space, middle scale
GmL.Nodes.bc = centrality(GmL, 'betweenness'); 
data(:,1) = scaling(GmL.Nodes.bc,'sum');
% betweenness, weighted L-space by link travel time, middle scale
GmL.Nodes.wbc = centrality(GmL, 'betweenness','Cost', GmL.Edges.TravelTime); 
data(:,2) = scaling(GmL.Nodes.wbc,'sum');
plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'betweenness (unweighted L-space)',colormapmat);
plotNodeColormap(MPTN.Stops,MPTN.Links,data,2,'betweenness (weighted L-space)',colormapmat);
% betweenness comparison, middle scale
cmpdata = (scaling(GmL.Nodes.wbc,'sum') - scaling(GmL.Nodes.bc,'sum'));
plotCmpColormap(MPTN.Stops,MPTN.Links,cmpdata,'comparison (weighted - unweighted)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% P space for middle scale
hourlist = [7,8,9];
[GmP,~] = buildWeightedPspaceGraph(MPTN,SF,hourlist);
% betweenness, unweighted P-space, middle scale
GmP.Nodes.bc = centrality(GmP, 'betweenness'); 
data(:,1) = scaling(GmP.Nodes.bc,'sum');
% betweenness, weighted P-space by headway, middle scale
GmP.Nodes.wbc = centrality(GmP, 'betweenness','Cost', GmP.Edges.Weight); 
data(:,2) = scaling(GmP.Nodes.wbc,'sum');

plotNodeColormap(MPTN.Stops,MPTN.Links,data,1,'betweenness (unweighted P-space)',colormapmat);
plotNodeColormap(MPTN.Stops,MPTN.Links,data,2,'betweenness (weighted P-space)',colormapmat);
% betweenness comparison, middle scale
cmpdata = (scaling(GmP.Nodes.wbc,'sum') - scaling(GmP.Nodes.bc,'sum'));
plotCmpColormap(MPTN.Stops,MPTN.Links,cmpdata,'comparison (weighted - unweighted)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






