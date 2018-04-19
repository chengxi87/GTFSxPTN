function C = formMergingStopList(A)

% C: Rows in Stops to be merged

flag = zeros(length(A),1);
C = cell(0);
for k = 1:length(A)
    if flag(k)==0
        p1 = k;
        flag(k) = 1;
        p2 = p1;
        for ki = 1:length(p1)
            node = p1(ki);
            p2 = union(p2,find(A(node,:)==1));
        end
        while length(p2)~=length(p1)
            p1 = p2;
            p2 = p1;
            for ki = 1:length(p1)
                node = p1(ki);
                p2 = union(p2,find(A(node,:)==1));
            end
        end
        for ki = 1:length(p2)
            flag(p2(ki)) = 1;
        end
        C{end+1} = p2;
    end
end

end