function fft2show(F)

FL = log10(eps + abs(F));
imshow(FL / max(FL(:)))
colormap(jet(64))
