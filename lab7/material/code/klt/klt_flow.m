function [dx, dy] = klt_flow(I, J, ws);
% Perform optical flow estimation using Lucas-Kanade registration.
%
% [dx, dy] = klt_flow(I, J, ws) returns the horizontal and vertical displacements,
% dx and dy, between grayscale images I and J, using a window size ws.

% check sizes
if (size(I) ~= size(J)), error('input images are not the same size'), end
[r, c] = size(I);
ws = max(3, ws);

% keep luminance value only
I = im2double(I); if(ndims(I) > 2), I = rgb2gray(I); end
J = im2double(J); if(ndims(J) > 2), J = rgb2gray(J); end

% derivative filters
fx = (1/2) * [-1 1; -1 1];
fy = fx';

% image derivatives
Ix = imfilter((I+J)/2, fx, 'replicate');
Iy = imfilter((I+J)/2, fy, 'replicate');

% frame difference (temporal derivative)
h  = imfilter(I - J, (1/4) * ones(2), 'replicate');

% Gaussian window for averaging
w = fspecial('gaussian', ws, (ws-1)/2);

% components of matrix G
A = imfilter(Ix.^2, w, 'replicate', 'conv'); 
B = imfilter(Iy.^2, w, 'replicate', 'conv');
C = imfilter(Ix.*Iy, w, 'replicate', 'conv');

% components of vector e
ex = imfilter(Ix.*h, w, 'replicate', 'conv'); 
ey = imfilter(Iy.*h, w, 'replicate', 'conv'); 

% initialization of displacements
dx = zeros(size(I));
dy = zeros(size(I));

for i = 1:r
	for j = 1:c

		% linear system to solve
		H = [A(i,j) C(i,j); C(i,j) B(i,j)];
		e = [ex(i,j) ey(i,j)]';
		d = pinv(H) * e;
      
		% storage of displacements
		dx(i,j) = d(1);
		dy(i,j) = d(2);

	end
end

% singular cases
dx(isnan(dx)) = 0;
dy(isnan(dy)) = 0;
