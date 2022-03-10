function corrected_peaks = correct_misaligned(misaligned_indices, peaks)

corrected_peaks = peaks;

valid_indices = and(misaligned_indices > 1, misaligned_indices < length(corrected_peaks) - 1);
misaligned_indices = misaligned_indices(valid_indices);
prev_peaks = corrected_peaks(misaligned_indices - 1);
next_peaks = corrected_peaks(misaligned_indices + 1);

half_ibi = (next_peaks - prev_peaks) / 2;
peaks_interp = prev_peaks + half_ibi;

corrected_peaks(misaligned_indices) = [];
corrected_peaks = round(sort(cat(2, corrected_peaks, peaks_interp)));
