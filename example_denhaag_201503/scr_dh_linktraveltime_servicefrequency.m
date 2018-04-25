clc;clear all;

str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

% necessary parameters
lineIdList = [1,2,3,4,6,8,9,11,12,15,16,17,19,42,44,83];
date = '20150304';
prefix = 'HTM';

%% link travel times 
LTT = createLinkTravelTimes(lineIdList,date,prefix);

%% stop-to-stop service frequency
% Elapsed time is 7567.584129 seconds.
tic;
SF = createStop2StopServiceFrequency(lineIdList,date,prefix);
toc;