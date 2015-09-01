function draw_bb(img, y, x, opac)

% plot bounding box on image; hold on is assumed

if nargin < 4
    opac = 0.4;
end

sy = size(img, 1) / 2;
sx = size(img, 2) / 2;

h = fill(x + [-sx;sx;sx;-sx], y + [-sy;-sy;sy;sy], 'r');
alpha(h, opac);    
