clc;clear all;close all;
% addpath
str=pwd;
index_dir=findstr(str,'\');
str_temp=str(1:index_dir(end)-1);
addpath(str_temp);
% load the network
OPTN = load('ams_operation_tramnetwork.mat'); % operation PTN

% nStops = length(StopsUpdate);
% D = zeros(nStops,nStops);
% for i = 1:nStops-1
%     for j = i+1:nStops
%         if ~isempty(intersect(LrUpdate{i},LrUpdate{j}))
%             D(i,j) = inf;
%         else
%             D(i,j) = pdist2([StopsUpdate(i).x,StopsUpdate(i).y],[StopsUpdate(j).x,StopsUpdate(j).y]);
%         end
%     end
% end
% 
% B = sort(D(D~=inf&D~=0));
% theta = 0.0017;
% A = createStepTwoAdj(StopsUpdate,D,theta);

