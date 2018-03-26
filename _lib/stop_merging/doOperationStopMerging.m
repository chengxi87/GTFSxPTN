function Stops = doOperationStopMerging(OPTN,theta)
%% Algorithm to merge stops based on [name, route ID, geospace]
% check out the paper for more details

%%
% Step 1
[OPTN.Stops.childStops] = OPTN.Stops.ID;
Lr = createStopsRouteLabelSet(OPTN.Stops,OPTN.Routes);
Ln = {OPTN.Stops.name}';
A = createStepOneAdj(OPTN.Stops,Ln,Lr);
C = formMergingStopList(A)';     
StopsUpdate = mergeStopsWithList(OPTN.Stops,C);
LrUpdate = updateLr(Lr,C);

% Step 2
A = createStepTwoAdj(StopsUpdate,LrUpdate,theta);
C = formMergingStopList(A)';
Stops = mergeStopsWithList(StopsUpdate,C);

end
