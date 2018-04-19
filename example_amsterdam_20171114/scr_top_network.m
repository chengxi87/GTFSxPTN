clc;clear all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
addpath([pwd '\outputs']);


MPTN = load('ams_middle_tramnetwork.mat');

[Stops,Links,Routes,LinkIdxTable] = buildTopScalePTN(MPTN);