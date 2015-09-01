function points = moravec(I)

% Moravec corner detector

% keep luminance value only
I = im2double(I);
if(ndims(I) == 3), I = rgb2gray(I); end

D10 = imfilter(I, .5 * [-1 1], 'replicate');
D11 = imfilter(I, .5 * [-1 0; 0 1], 'replicate');
D01 = imfilter(I, .5 * [-1 1]', 'replicate');
D_11 = imfilter(I, .5 * [0 -1; 1 0], 'replicate');

w = ones(3);
E10 = imfilter(D10.^2, w, 'replicate');
E11 = imfilter(D11.^2, w, 'replicate');
E01 = imfilter(D01.^2, w, 'replicate');
E_11 = imfilter(D_11.^2, w, 'replicate');

R = min(min(min(E10, E11), E01), E_11);
[r, c] = local_max(R);
points = [r c];