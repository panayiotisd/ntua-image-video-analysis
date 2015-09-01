function points = harris_multi(I, s_step, s_n)

% Multiple scale Harris corner detector
%
% P = harris_multi(I, s_step, s_n) returns the Harris corners of grayscale image I.
% P is an Nx3 matrix where N is the number of corners extracted. The  first two
% columns contain the coordinates of points and the third column contains their 
% scale indices. s_step and s_n are the ratio between successive scales and total
% number of scales, respectively.

% keep image intensity only
I = im2double(I);
if(ndims(I) == 3), I = rgb2gray(I); end

% scales
s_array = s_step .^ (1:s_n);

% multi-scale Harris points
points = zeros(0,3);
for i = 1:s_n
disp(['Harris scale ' num2str(i) ' / ' num2str(s_n)])

	% scale (standard deviation)
	s_i = s_array(i);   % integration scale
	s_d = 0.7*s_i;      % derivation scale

	% derivative filter
	x  = -round(3*s_d):round(3*s_d);
	dx = -x / (s_d^3*sqrt(2*pi)) .* exp(-x.*x/(2*s_d^2));
	dy = dx';

	% image derivatives
	X = imfilter(I, dx, 'replicate', 'conv');
	Y = imfilter(I, dy, 'replicate', 'conv');

	% smoothing with Gaussian window
	g = fspecial('gaussian', max(1, fix(6*s_i+1)), s_i);
	A = imfilter(X.^2, g, 'replicate', 'conv'); 
	B = imfilter(Y.^2, g, 'replicate', 'conv');
	C = imfilter(X.*Y, g, 'replicate', 'conv');

	% corner response
	k = 0.06; 
	R = (A.*B - C.^2) - k * (A + B).^2;

	% local maxima in 3x3 neighborgood
	[r, c, mx] = local_max(R, 3*s_i);

	% find local maxima greater than 1% of maximum value
	[r, c] = find(mx > 0.1 * max(mx(:)));

	% build interest points
	n = length(r);
	points = [points; r c i*ones(n,1)];

end
