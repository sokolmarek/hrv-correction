function th = estimate_th(x, alpha, ww)

hw = (ww - 1) / 2;
padx = padarray(abs(x), [0 hw], 'both');
th = zeros(1, length(x));
j = 1;

for i = ww-hw:length(padx)-hw
    win = padx(i-hw:i+hw);
    th(j) = alpha * (diff(quantile(win, [.25 .75])) / 2);
    j = j + 1;
end