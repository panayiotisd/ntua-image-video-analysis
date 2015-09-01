function draw_points(I, points, name, rect)

% draw_points(I, points, name, rect) opens a new window, displays image i and 
% draws points over image. name is the name of the new window. points is a Nx2
% or Nx3 matrix containing the point coordinates and optionally their scales in
% last column. rect contols whether points are drawn as rectangles (default
% when no scales are given), or circles.

if(nargin < 3 | isempty(name)), name = 'Detected points'; end
if(nargin < 4 | isempty(rect)), rect = size(points, 2) == 2; end
if(nargin < 5), map = []; end

clf, imshow(I), title(name), hold on, axis off;

if(ndims(I)==3), color = 'w'; else color = 'b'; end
if(rect), curv = [0 0]; else curv = [1 1]; end

scales = size(points, 2) == 3;
if(~scales), s = 2; end

for i=1:size(points, 1)
	if(any(isnan(points(i,:)))), continue, end
	if(scales), s = points(i,3); end
	x = points(i,2); y = points(i,1);
	rectangle('Position', [x-s, y-s, 2*s+1, 2*s+1], 'Curvature', curv, 'EdgeColor', color, 'LineWidth', 1);
end
