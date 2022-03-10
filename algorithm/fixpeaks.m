function [artifacts, peaks_clean] = fixpeaks(peaks, fs, iterative, show)
%% FIXPEAKS - HRV time series artifact correction
%
% Input arguments:
%   peaks - vector containing indices of detected peaks (R waves locations)
%   fs - sampling frequency (default = 1000)
%   iterative - repeatedly apply the artifact correction (default = true)
%   show - visualize artifacts and artifact thresholds (default = false)
%
% Output:
%   artifacts - struct containing indices of detected artifacts
%   peaks_clean - vector of corrected peak values (indices)
%
% Example:
%   load peaks.txt  % your file containing indices of detected R waves
%   [artifacts, peaks_clean] = fixpeaks(peaks, 500, true, true);
% 
% Marek Sokol, 2022.
%
arguments
    peaks (1,:) double {mustBeNumeric, mustBeReal, mustBePositive}
    fs (1,1) double {mustBeNumeric, mustBeReal, mustBePositive} = 1000
    iterative logical = true
    show logical = false
end

[artifacts, subspaces] = find_artifacts(peaks, fs);
peaks_clean = correct_artifacts(artifacts, peaks);

if iterative
    n_artifacts_current = sum(structfun(@(x) size(x, 2), artifacts));

    while true
        [new_artifacts, new_subspaces] = find_artifacts(peaks_clean, fs);
        n_artifacts_previous = n_artifacts_current;
        n_artifacts_current = sum(structfun(@(x) size(x,2), new_artifacts));

        if n_artifacts_current >= n_artifacts_previous
            break
        end

        artifacts = new_artifacts;
        subspaces = new_subspaces;
        peaks_clean = correct_artifacts(artifacts, peaks_clean);
    end
end

if show
    plot_artifacts(artifacts, subspaces)
end