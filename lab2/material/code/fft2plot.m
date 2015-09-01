function fft2plot(F, color)

if(nargin < 1), color = 'b'; end

F = mean(F);
FL = log10(eps + abs(F));
plot(FL, color)
