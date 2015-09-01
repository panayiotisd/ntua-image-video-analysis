function snr = snr(S, SN)

% signal to noise ratio
N = SN-S;
S = S - mean(S(:));
N = N - mean(N(:));
snr = 10 * log10(sum(S(:).^2) / sum(N(:).^2));
