function [points, A, B, C, R] = harris(I)

% Extract feature points using the Harris corner detector.
%
% [P, A, B, C, R] = harris(I) returns the Harris corners of grayscale image I.
% P is an Nx2 matrix where N is the number of corners extracted. Also returns
% intermediate results A,B,C and response function R.

% keep luminance value only
I = im2double(I);
if(ndims(I) == 3), I = rgb2gray(I); end

% derivative filter
dx = .5 * [-1 0 1];
dy = dx';

% image derivatives
X = imfilter(I, dx, 'replicate');
Y = imfilter(I, dy, 'replicate');

% smoothing with Gaussian window
s = 1.5;
g = fspecial('gaussian', max(1, fix(6*s+1)), s);
A = imfilter(X.^2, g, 'replicate', 'conv'); 
B = imfilter(Y.^2, g, 'replicate', 'conv');
C = imfilter(X.*Y, g, 'replicate', 'conv');

% corner response
k = 0.06; 
R = (A.*B - C.^2) - k * (A + B).^2;

% local maxima in 3x3 neighborgood
[r, c, mx] = local_max(R, 3*s);

% find local maxima greater than .1% of maximum value
[r, c] = find(mx > 0.001 * max(mx(:)));

% return interest points
points = [r c];
