function v = scaling(v,type)

switch type
    case 'sum'
        v = v./(sum(v));
    case 'max'
        v = (v-min(v))./(max(v)-min(v));
end

end