function [t, r, A_t, A_m] = hough_lines(Acc, T)

if(nargin < 2), T = .4; end

[K_t, K_r] = size(Acc);

A_t = Acc .* (Acc > T);
[t, r, mx] = local_max(rot90(A_t, -1));

t = (t - 1) / K_t * pi;
r = (r - 1) / (K_r-1) * 2 - 1;
A_m = rot90(mx ~= 0);


