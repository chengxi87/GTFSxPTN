function LrUpdate = updateLr(Lr,C)

LrUpdate = [];
for i = 1:numel(C)
    M = {};
    for j = C{i}
        if ischar(Lr{j})
            tmp = {Lr{j}};
        else
            tmp = Lr{j};
        end
        M = unique([M,tmp]);
    end
    LrUpdate{i,1} = M;     
end

end