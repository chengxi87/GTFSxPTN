function [Stops,Links,Routes,StopIdxTable,LinkIdxTable] = ...
    buildPlanningNetwork(OPTN,stopMergingPara)
%%
% INPUT
%  - OPTN: Struct containing Stops,Links,Routes of Operation Public
%    Transport Network
%  - stopMergingPara: A parameter used in the stop merging process. It
%    specifies what percentage of the top closest stop pairs at the operation
%    network level should be merged. The parameter can be determined after
%    an evaluation.
% OUTPUT
%  - Stops, Links, Routes at the planning level 
%--------------------------------------------------------------------------
% Ding Luo, 2018/03/23
%%
% merge stops
[Stops,StopIdxTable] = mergeOperationStops(OPTN,stopMergingPara,1);
% update Links and Routes based on stop merging result
[Links,LinkIdxTable] = buildPlanningLinks(OPTN,StopIdxTable);
Routes = buildPlanningRoutes(OPTN,StopIdxTable,LinkIdxTable);

end