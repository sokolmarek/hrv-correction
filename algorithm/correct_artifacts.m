function peaks = correct_artifacts(artifacts, peaks)

extra_indices = artifacts.extra;
missed_indices = artifacts.missed;
ectopic_indices = artifacts.ectopic;
longshort_indices = artifacts.longshort;

if extra_indices
    peaks = correct_extra(extra_indices, peaks);
    missed_indices = update_indices(extra_indices, missed_indices, -1);
    ectopic_indices = update_indices(extra_indices, ectopic_indices, -1);
    longshort_indices = update_indices(extra_indices, longshort_indices, -1);
end

if missed_indices
    peaks = correct_missed(missed_indices, peaks);
    ectopic_indices = update_indices(missed_indices, ectopic_indices, 1);
    longshort_indices = update_indices(missed_indices, longshort_indices, 1);
end

if ectopic_indices
    peaks = correct_misaligned(ectopic_indices, peaks);
end

if longshort_indices
    peaks = correct_misaligned(longshort_indices, peaks);
end