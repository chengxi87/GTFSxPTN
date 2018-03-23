function table = getTable(tableName,gtfsTables)
idx = find(strcmp(tableName,{gtfsTables{:,1}}));
table = gtfsTables{idx,3};
end