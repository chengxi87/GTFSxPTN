function Stops = doStopMerging4BSPTN(BSPTN,theta,exceptionList)
%% Algorithm to merge stops based on [name, route ID, geospace]
% check out the paper for more details

%%
% Step 1
[BSPTN.Stops.childStops] = BSPTN.Stops.ID;
Lr = createStopsRouteLabelSet(BSPTN.Stops,BSPTN.Routes);
Ln = {BSPTN.Stops.name}';
A = createStepOneAdj(BSPTN.Stops,Ln,Lr);
C = formMergingStopList(A)';     
StopsUpdate = mergeStopsWithList(BSPTN.Stops,C);
LrUpdate = updateLr(Lr,C);

% Step 2
A = createStepTwoAdj(StopsUpdate,LrUpdate,theta,exceptionList);
C = formMergingStopList(A)';
Stops = mergeStopsWithList(StopsUpdate,C);

end
