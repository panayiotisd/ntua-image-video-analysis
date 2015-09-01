% initialization
close all, clear;

% motion vector parameters
b = [8 8]; % block size
d = [4 4]; % max displacement

bx = b(1); by = b(2);
dx = d(1); dy = d(2);

% show figures or not
fig = 1; 

% root folder and filenames for frames in sequence
root = '../../data/';
seq = 'coast'; frame = 30; frames = 10:65;
%seq = 'bike'; frame = 72; frames = 40:85;
%seq = 'garden'; frame = 20; frames = 10:35;
%seq = 'tennis'; frame = 30; frames = 30;
file_pat = [root seq '/' seq '_%03d.gif']; 

% main loop over frames
for f = frame, disp(f)

	I = indread(sprintf(file_pat, f));
	J = indread(sprintf(file_pat, f+1));

	if(fig)
	figure, imshow(I), title('frame n, I');
	figure, imshow(J), title('frame n+1, J');
	end

	% sizes
	[ny, nx, c] = size(I);
	nby = ny / by;
	nbx = nx / bx;

	% zero padding
	Z = zeros(ny+2*dy, nx+2*dx, c);
	Z((1:ny)+dy, (1:nx)+dx, :) = I;

	% motion estimation
	[vx, vy] = bm(Z, J, b, d);
	if(fig), figure, quiver(1:nbx, nby:-1:1, vx, vy), title('motion vectors'), end

	% motion vector filtering
	f_vx = medfilt2(vx);
	f_vy = medfilt2(vy);
	if(fig), figure, quiver(1:nbx, nby:-1:1, f_vx, f_vy), title('filtered motion vectors'), end

	% main mobile object
	obj = f_vx < -1; % for coast
	%obj = f_vx > 1; % for garden
	%obj = f_vy > 0; % for bike
	%obj = f_vy > 0 & f_vx == 0; % for tennis

	% expand image and get binary mask of mobile object 
	m = expand(obj, b);
	if(fig), figure, imshow(m), end

end
