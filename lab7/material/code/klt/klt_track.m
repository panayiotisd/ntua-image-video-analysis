% Feature point tracking with the Kanade-Lucas-Tomasi tracker

% initialization
close all, clear;
fig = figure;

% window size
ws = 9; 

% initial feature points
points = [];

% root folder and filenames for frames in sequence
root = '../../data/';
%seq = 'coast'; frames = 0:298;
seq = 'bike'; frames = 1:142;
%seq = 'garden'; frames = 1:148;
%seq = 'tennis'; frames = 1:147;
file_pat = [root seq '/' seq '_%03d.gif']; 

% output avi file
video = 0;
if(video), avi_out = avifile(['../../out/' seq '.avi'], 'FPS', 10, 'COMPRESSION', 'None'); end

% first frame
I = indread(sprintf(file_pat, frames(1)), 2); % crop two-pixel border

for f = frames,
	ftitle = sprintf('Frame %d', f);
	disp(ftitle)

	% read next frame
	file = sprintf(file_pat, f+1);
	if(~exist(file, 'file')), disp([file ' does not exist']), continue, end
	J = indread(file, 2); % crop two-pixel border

	% grayscale
	Ig = rgb2gray(I);
	Jg = rgb2gray(J);

	% feature point detection & tracking
	[d, points, R] = klt_feat(Ig, Jg, ws, points);
	n = size(points,1);

	% display of current frame + feature points
	pt = [points (ws-1)/2*ones(n,1)]; % append point sizes
	draw_points(I, pt, ftitle, 1)

	% output current frame to avi
	F = getframe(fig);
	if(video), avi_out = addframe(avi_out, F); end

	%pause

	% update of feature point locations with displacements
	points = points + d;

	% keep frame for next iteration;
	I = J;

end

% close avi file
if(video), avi_out = close(avi_out); end