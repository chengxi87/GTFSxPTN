clc;clear all;close all;
% add path 
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

%%

createTimetables()