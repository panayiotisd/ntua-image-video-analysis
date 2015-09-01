function [I,V,R] = harris_test(theta, dt)

% Constructs an image of a corner, starting at theta and with an angle of dt.
% Then return the image, I, the eigenvectors, V, of the autocorrelation
% matrix at the image center, and the Harris response function, R, again at
% the center.

% image construction
N = 63; [x,y] = freqspace(N, 'meshgrid'); j = sqrt(-1); a = angle(x + j * y);
D = .1 * ones(N, N); D(a >= theta & a <= theta+dt) = .9; D = flipud(D); 

% image derivatives
I = D; dx = .5 * [-1 0 1]; dy = dx';
X = imfilter(I, dx, 'replicate');
Y = imfilter(I, dy, 'replicate');

% smoothing with Gaussian window
s = 1.5; g = fspecial('gaussian', max(1, fix(6*s+1)), s);
A = imfilter(X.^2, g, 'replicate', 'conv'); 
B = imfilter(Y.^2, g, 'replicate', 'conv');
C = imfilter(X.*Y, g, 'replicate', 'conv');

% Eigenvalues & response
c = floor((N+1)/2);
M = [A(c,c) C(c,c); C(c,c) B(c,c)];
V = flipud(eig(M))'; 
R = V(1) * V(2) - .06 * (V(1) + V(2))^2;
