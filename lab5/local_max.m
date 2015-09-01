function [r, c, mx] = local_max(X, rad)
% Determine the local maxima of a matrix
%
% [r, c, mx] = local_max(X, rad) returns the local maxima of the MxN matrix X
% in a disk-shaped neighboorhood area of radius rad. r and c are the row and
% column positions of local maxima, and mx an MxN matrix containing values
% of X on those positions. 
    
if(nargin < 2), rad = 3; end

mask  = fspecial('disk', rad) > 0;
n = sum(mask(:));
m_1st = ordfilt2(X, n, mask);
m_2nd = ordfilt2(X, n-1, mask);
idx = m_1st == X & m_1st ~= m_2nd;
[r,c] = find(idx);
mx = zeros(size(X));
mx(idx) = X(idx);
