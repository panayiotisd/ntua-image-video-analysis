function [vx, vy] = bmatch(Z, J, b, d)

% Block matching
%
% [mvx, mvy] = bm(Z, J, b, d) performs block matching between zero-padded
% reference frame Z and new frame J and return motion vectors (mvx, mvy),
% using block size b and miximum displacement d.

if(nargin<3), b = [8 8]; end % block size
if(nargin<4), d = [4 4]; end % max displacement

bx = b(1); by = b(2);
dx = d(1); dy = d(2);

% number of blocks
[ny, nx, c] = size(J);
nby = ny / by;
nbx = nx / bx;

% motion vectors
vx = zeros(nby, nbx);
vy = zeros(nby, nbx);

% loop over blocks
for ibx = 1:nbx
    for iby = 1:nby
	E = zeros(2*dy+1, 2*dx+1);
	% loop over displacements
        for rx = -dx:dx
            for ry = -dy:dy
		x = bx*(ibx-1) + (1:bx);
		y = by*(iby-1) + (1:by);
		D = J(y, x, :) - Z(y+ry+dy, x+rx+dx, :); % block error
		E(ry+dy+1, rx+dx+1) = sum(D(:).^2);
            end
        end
	% minimum error
	E(dy+1, dx+1) = NaN;
	[fy, fx] = find(E == min(E(:)));
	vx(iby, ibx) = fx(1) - (dx+1);
	vy(iby, ibx) = fy(1) - (dy+1);
    end
end
vy = -vy;