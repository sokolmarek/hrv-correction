function plot_artifacts(artifacts, subspaces)

ectopic_indices = artifacts.ectopic;
missed_indices = artifacts.missed;
extra_indices = artifacts.extra;
longshort_indices = artifacts.longshort;

rr = subspaces.rr;
drrs = subspaces.drrs;
mrrs = subspaces.mrrs;
s12 = subspaces.s12;
s22 = subspaces.s22;
c1 = subspaces.c1;
c2 = subspaces.c2;

subplot(3, 2, [1 2])
plot(rr, 'k')
xlim([0 length(rr)])
hold on
scatter(longshort_indices, rr(longshort_indices), 15, 'c', 'filled')
scatter(ectopic_indices, rr(ectopic_indices), 15, 'r', 'filled')
scatter(extra_indices, rr(extra_indices), 15, 'm', 'filled')
scatter(missed_indices, rr(missed_indices), 15, 'g', 'filled')
legend('', 'Long/Short', 'Ectopic', 'False positive', 'False negative', ...
    'Location','NorthEastOutside')
title('Artifact types')

% Th1
subplot(323)
plot(abs(drrs))

xlim([0 length(drrs)]); ylim([0 5])
hold on
yline(1, 'r--', 'Threshold 1')
title('Consecutive-difference criterion')

% Th2
subplot(324)
plot(abs(mrrs))
xlim([0 length(mrrs)]); ylim([0 5])
hold on
yline(3, 'r--', 'Threshold 2')
title('Difference-from-median criterion')

% Subspaces
subplot(325)
scatter(drrs, s12, 15, 'k', 'filled')
xlim([-10 10]); ylim([-5 5])
xlabel('S11'); ylabel('S12'); title('Subspace S12')
hold on
scatter(drrs(longshort_indices), s12(longshort_indices), 15, 'c', 'filled')
scatter(drrs(ectopic_indices), s12(ectopic_indices), 15, 'r', 'filled')
scatter(drrs(extra_indices), s12(extra_indices), 15, 'm', 'filled')
scatter(drrs(missed_indices), s12(missed_indices), 15, 'g', 'filled')

verts0 = [-10, 5; -10, -c1 * -10 + c2; -1, -c1 * -1 + c2; -1, 5];
verts1 = [1, -c1 * 1 - c2; 1, -5; 10, -5; 10, -c1 * 10 - c2];
pgon0 = polyshape(verts0(:, 1), verts0(:, 2));
pgon1 = polyshape(verts1(:, 1), verts1(:, 2));
plot(pgon0, 'FaceAlpha', .05, 'FaceColor', 'k', 'EdgeColor', 'k')
plot(pgon1, 'FaceAlpha', .05, 'FaceColor', 'k', 'EdgeColor', 'k')

subplot(326)
scatter(drrs, s22, 15, 'k', 'filled')
xlim([-10 10]); ylim([-10 10])
xlabel('S21'); ylabel('S22'); title('Subspace S21')
hold on
scatter(drrs(longshort_indices), s22(longshort_indices), 15, 'c', 'filled')
scatter(drrs(ectopic_indices), s22(ectopic_indices), 15, 'r', 'filled')
scatter(drrs(extra_indices), s22(extra_indices), 15, 'm', 'filled')
scatter(drrs(missed_indices), s22(missed_indices), 15, 'g', 'filled')

verts2 = [-10, 10; -10, 1; -1, 1; -1, 10];
verts3 = [1, -1; 1, -10; 10, -10; 10, -1];
pgon2 = polyshape(verts2(:, 1), verts2(:, 2));
pgon3 = polyshape(verts3(:, 1), verts3(:, 2));
plot(pgon2, 'FaceAlpha', .05, 'FaceColor', 'k', 'EdgeColor', 'k')
plot(pgon3, 'FaceAlpha', .05, 'FaceColor', 'k', 'EdgeColor', 'k')

