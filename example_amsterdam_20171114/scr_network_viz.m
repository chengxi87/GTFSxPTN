clc;clear all; close all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

BPTN = load('ams_bottom_tramnetwork.mat');
MPTN = load('ams_middle_tramnetwork.mat');
TPTN = load('ams_top_tramnetwork.mat');


plotNetworkWithGeo(BPTN.Links,BPTN.Stops);
figure;
plotNetworkNoGeo(MPTN.Links,MPTN.Stops);
figure;
plotNetworkNoGeo(TPTN.Links,TPTN.Stops);