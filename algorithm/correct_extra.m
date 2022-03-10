function corrected_peaks = correct_extra(extra_indices, peaks)

corrected_peaks = peaks;
corrected_peaks(extra_indices) = [];

