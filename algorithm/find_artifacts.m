function [artifacts, subspaces] = find_artifacts(peaks, fs)

c1 = 0.13;
c2 = 0.17;
alpha = 5.2;
ww = 91;
medfilt_order = 11;

rr = diff(peaks) / fs;
rr = [mean(rr) rr];

%% Artifact identification
drrs = diff(rr);
drrs = [mean(drrs) drrs];
th1 = estimate_th(drrs, alpha, ww);
drrs = drrs ./ th1;

padding = 2;
drrs_pad = padarray(drrs, [0 padding], 'symmetric', 'both');
drrs_pad(1:padding) = drrs_pad(1:padding) + 1;
drrs_pad(end - padding + 1:end) = drrs_pad(end - padding + 1:end) - 1;

s12 = zeros(1, length(drrs));
for d = padding + 1:(padding + length(drrs))
    if drrs_pad(d) > 0
        s12(d - padding) = max([drrs_pad(d - 1), drrs_pad(d + 1)]);
    elseif drrs_pad(d) < 0
        s12(d - padding) = min([drrs_pad(d - 1), drrs_pad(d + 1)]);
    end
end

s22 = zeros(1, length(drrs));
for d = padding + 1:(padding + length(drrs))
    if drrs_pad(d) >= 0
        s22(d - padding) = min([drrs_pad(d + 1), drrs_pad(d + 2)]);
    elseif drrs_pad(d) < 0
        s22(d - padding) = max([drrs_pad(d + 1), drrs_pad(d + 2)]);
    end
end

medrr = movmedian(rr, medfilt_order);
mrrs = rr - medrr;
mrrs(mrrs < 0) = mrrs(mrrs < 0) * 2;
th2 = estimate_th(mrrs, alpha, ww);
mrrs = mrrs ./ th2;


%% Artifacts classification
extra_indices = [];
missed_indices = [];
ectopic_indices = [];
longshort_indices = [];

i = 1;
while i < length(rr) - 2

    if abs(drrs(i)) <= 1
        i = i + 1;
        continue
    end

    eq1 = and(drrs(i) > 1, s12(i) < (-c1 * drrs(i) - c2));
    eq2 = and(drrs(i) < -1, s12(i) > (-c1 * drrs(i) + c2));

    if any([eq1, eq2])
        ectopic_indices = [ectopic_indices; i];
        i = i + 1;
        continue
    end

    if ~any([abs(drrs(i)) > 1, abs(mrrs(i)) > 3])
        i = i + 1; 
        continue
    end

    longshort_candidates = [i];

    if abs(drrs(i + 1)) < abs(drrs(i + 2))
        longshort_candidates = [longshort_candidates; i + 1];
    end

    for j = 1:length(longshort_candidates)
        eq3 = and(drrs(longshort_candidates(j)) > 1, s22(longshort_candidates(j)) < -1);
        eq4 = abs(mrrs(longshort_candidates(j))) > 3;
        eq5 = and(drrs(longshort_candidates(j)) < -1, s22(longshort_candidates(j)) > 1);

        if ~any([eq3, eq4, eq5])
            i = i + 1;
            continue
        end

        eq6 = abs(rr(longshort_candidates(j)) / 2 - medrr(longshort_candidates(j))) < th2(longshort_candidates(j));
        eq7 = abs(rr(longshort_candidates(j)) + rr(longshort_candidates(j) + 1) - medrr(longshort_candidates(j))) < th2(longshort_candidates(j));

        if all([eq5, eq7])
            extra_indices = [extra_indices; longshort_candidates(j)];
            i = i + 1;
            continue
        end

        if all([eq3, eq6])
            missed_indices = [missed_indices; longshort_candidates(j)];
            i = i + 1;
            continue
        end

        longshort_indices = [longshort_indices; longshort_candidates(j)];
        i = i + 1;
    end

end

artifacts.ectopic = ectopic_indices;
artifacts.missed = missed_indices;
artifacts.extra = extra_indices;
artifacts.longshort = longshort_indices;

subspaces.rr = rr;
subspaces.drrs = drrs;
subspaces.mrrs = mrrs;
subspaces.s12 = s12;
subspaces.s22 = s22;
subspaces.c1 = c1;
subspaces.c2 = c2;
