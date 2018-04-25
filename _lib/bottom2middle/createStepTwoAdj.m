function A = createStepTwoAdj(Stops,LrUpdate,theta,exceptionList)

nStops = length(Stops);
A = zeros(nStops,nStops);
for i = 1:nStops-1
    for j = i+1:nStops
        % 1 = two stops from the same route
        % 0 = twos stops from different routes
        dr = ~isempty(intersect(LrUpdate{i},LrUpdate{j})); % route info
        if ~isempty(exceptionList)
            [ri,ci,~] = find(strcmp(Stops(i).name,exceptionList));
            [rj,cj,~] = find(strcmp(Stops(j).name,exceptionList));
            ri = unique(ri);
            rj = unique(rj);
            if ~isempty(ri) & ~isempty(rj) & isequal(ri,rj) & strcmp('merge', exceptionList{ri,3})
                dg = 0;
            elseif ~isempty(ri) & ~isempty(rj) & strcmp('separate', exceptionList{ri,3})
                dg = Inf;
            else
                dg = pdist2([Stops(i).x,Stops(i).y],[Stops(j).x,Stops(j).y]); % physical distance
            end
        else
            dg = pdist2([Stops(i).x,Stops(i).y],[Stops(j).x,Stops(j).y]); % physical distance
        end
%         if ~dr & dg <= theta
        if dg <= theta
            A(i,j) = 1;
            A(j,i) = 1;
        end   
    end
end

end