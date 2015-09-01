function fft2mesh(F)

FL = log10(eps + abs(F));
[fx,fy] = freqspace(size(FL));
mesh(fx, fy, FL); 