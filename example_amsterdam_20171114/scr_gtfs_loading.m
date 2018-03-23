
clc;clear all;close all;
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);

gtfsTables = loadGTFS();