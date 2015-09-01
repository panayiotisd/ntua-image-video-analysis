function snr = snr(S, SN)

% signal to noise ratio
N = SN-S;
S = S - mean(mean(S));
N = N - mean(mean(N));
snr = 10 * log10(sum(sum(sum(S.^2))) / sum(sum(sum(N.^2))));
