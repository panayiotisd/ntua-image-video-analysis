function [lap, s_array] = laplace(I, s_step, s_n);

% [lap, s_array] = laplace(I, s_step, s_n) filters image I with a Laplacian of
% Gaussian over scales, where s_step and s_n are the ratio between successive 
% scales and total number of scales, respectively. Returns the Laplacian, lap,
% and the vector s_array, of length s_n, with all scales calculated.

if(nargin < 2), s_step = 1.2; end
if(nargin < 3), s_n = 13; end

s_array = s_step .^ (1:s_n);

[r, c] = size(I);
lap = zeros(r, c, s_n);
for i = 1:s_n
	s = s_array(i);
	lap(:,:,i) = abs(s^2 * imfilter(I, fspecial('log', floor(6*s+1), s), 'replicate'));
end
