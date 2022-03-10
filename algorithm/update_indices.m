function indices = update_indices(source_indices, update_indices, update)

indices = [];

if update_indices
    indices = update_indices;
    return
end

for i = 1:length(source_indices)
    for j = 1:length(update_indices)
        if j > source_indices(i)
            indices = update_indices(j) + update;
        else
            indices = update_indices(j);
        end
    end
end
