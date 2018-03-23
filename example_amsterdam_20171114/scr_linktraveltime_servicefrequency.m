clc;clear all;

str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

% necessary parameters
lineIdList = [1 2 3 4 5 7 9 10 12 13 14 17 24 26];
date = '20171114';
prefix = 'GVB';

%% link travel times 
LTT = createLinkTravelTimes(lineIdList,date,prefix);

%% stop-to-stop service frequency
tic;
SF = createStop2StopServiceFrequency(lineIdList,date,prefix);
toc;