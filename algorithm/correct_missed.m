function corrected_peaks = correct_missed(missed_indices, peaks)

corrected_peaks = peaks;

valid_indices = and(missed_indices > 1, missed_indices < length(corrected_peaks));
missed_indices = missed_indices(valid_indices);
prev_peaks = corrected_peaks(missed_indices - 1);
next_peaks = corrected_peaks(missed_indices);
added_peaks = round(prev_peaks + (next_peaks - prev_peaks) / 2);

corrected_peaks = sort([corrected_peaks added_peaks]);
