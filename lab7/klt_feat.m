function [d, points, R] = klt_feat(I, J, ws, points);
% Δανασής Παναγιώτης Α.Μ. 03109004
%
% Η συνάρτηση αναλύει την κίνηση που παρουσιάζεται μεταξύ δύο διαδοχικών καρέ I και J μιας ακολουθίας
% βίντεο και πραγματοποιεί ανίχνευση και παρακολούθηση σημείων ενδιαφέροντος με τη μέθοδο
% Kanade-Lucas-Tomasi (KLT). Χρησιμοποιεί παράθυρο μεγέθους ws και επιστρέφει τα διανύσματα μετατόπισης d
% και τις συντεταγμένες των σημείων points, και τα δύο διαστάσεων N ? 2, όπου N το πλήθος των σημείων,
% καθώς και την εικόνα απόκρισης R, διαστάσεων όσο και η I, με την ελάχιστη ιδιοτιμή του πίνακα H.
%
% Αν τα σημεία points είναι διαθέσιμα από το προηγούμενο καρέ μπορούμε να τα δώσουμε ως είσοδο στην
% klt_feat. Στην περίπτωση αυτή η συνάρτηση ενημερώνει τα σημεία πριν υπολογίσει τις μετατοπίσεις.
% Διαφορετικά η είσοδος points θεωρείται κενή ([]).


% keep luminance value only
I = im2double(I); if(ndims(I) > 2), I = rgb2gray(I); end
J = im2double(J); if(ndims(J) > 2), J = rgb2gray(J); end

% check sizes
if (size(I) ~= size(J)), error('input images are not the same size'), end
s = size(I);
ws = max(3, ws);

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

% initialization of Response
R = zeros(size(I));

% feature response: minimum eigenvalue of H
R = 0.5 * (A + B - sqrt(((A - B).^2) + 4 * (C.^2)));

% local maxima in 3x3 neighborgood
[r, c, mx] = local_max(R, 3);

% new feature points, above threshold for min. eigenvalue
[r, c] = find(mx>0.007);
new_pt = [r, c];

% combine new features with pre-existing ones
if(isempty(points) | size(points,1) < 1 | isnan(points(:)))
	% allocate new feature points
	points = new_pt;
else
	% remove new points that overlap previous ones
	valid = zeros(1,size(new_pt,1));
	for k = 1:size(new_pt,1)
		p = ones(size(points,1),1) * new_pt(k,:);
		valid(k) = min(max(abs(p - points)')) > ws;
	end
	% append non-overlapping new points to previous ones
	new_pt(~valid, :) = [];
	points = [points; new_pt];
end


% initialization of displacements
d = zeros(size(points));
for k = 1:size(points,1);
	% point location
	x = points(k, 1);
	y = points(k, 2);
	
	% remove invalid points: make them NaN
	if ( (x < 1) | (x > s(1)) | (y < 1) | (y > s(2)) )
		points(k, 1) = NaN;
		points(k, 2) = NaN;
	end;
	
	% check response again, remove points if below threshold: make them NaN
	threshold = 0.005;
	if ( (x < threshold) | (y < threshold) )
		points(k, 1) = NaN;
		points(k, 2) = NaN;
	end;
	
	if ( points(k, 1)>0 & points(k, 2)>0 )
		% solve linear system
		x = int32(x);
		y = int32(y);
		H = [A(x,y) C(x,y); C(x,y) B(x,y)];
		e = [ex(x,y) ey(x,y)]';
		displacements = pinv(H) * e;
		
		% swap dx with dy: coordinates given as (row,column)
		d(k,2) = displacements(1);
		d(k,1) = displacements(2);
	end
end