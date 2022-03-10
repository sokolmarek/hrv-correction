# HRV time series artifact correction [![View HRV artifact correction on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/107779-hrv-artifact-correction)

Heart rate variability (HRV) is a standard metric for assessing autonomic nervous system function, psychophysiological stress, and exercise intensity and recovery. Extra, missing, or misaligned beat detections in HRV measurements can cause severe distortion in HRV analysis. 

This repository contains MATLAB code for HRV time series artifact correction based on [NeuroKit](https://github.com/neuropsychology/NeuroKit) implementation. The correction algorithm proposed by Lipponen et al. (2019) uses time-varying thresholds calculated from the distribution of successive RR-interval discrepancies paired with a unique beat categorization methodology. 


## Usage/Examples
The function ```fixpeaks()``` has been provided to perform peak correction directly on data stored in MATLAB. The function can be used as follows:

```matlab
% Load your file containing indices of detected R waves, for example 
% peak.txt or use your variable that contains them
load peaks.txt

% Call the main function fixpeaks() 
[artifacts, peaks_clean] = fixpeaks(peaks, 500, true, true);
```

If the last argument ```show``` in the function is set to true, the detected artifacts and subspaces described in [1] are then visualized. Further input arguments are described in the function itself.


## Example of visual result

<p align="center">
  <img src="https://github.com/sokolmarek/hrv-correction/blob/main/assets/screenshot.png?raw=true" />
</p>

## References

 - [[1] Jukka A. Lipponen & Mika P. Tarvainen (2019): A robust algorithm for heart rate variability time series artefact correction using novel beat classification, Journal of Medical Engineering & Technology](https://www.tandfonline.com/doi/full/10.1080/03091902.2019.1640306)
 - [[2] Makowski, D., Pham, T., Lau, Z. J., Brammer, J. C., Lespinasse, F., Pham, H., Schölzel, C., & Chen, S. A. (2021). NeuroKit2: A Python toolbox for neurophysiological signal processing. Behavior Research Methods, 53(4), 1689–1696.](https://github.com/neuropsychology/NeuroKit)
