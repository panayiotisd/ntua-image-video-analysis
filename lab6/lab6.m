function [] = lab6()
	% Δανασής Παναγιώτης ΑΜ 03109004, τμήμα Πέμπτης.
	
    img1 = imread( 'eiffel_00.jpg' );
	[ points1, A, B, C, R ] = harris( img1 );
	
	img2 = imread( 'eiffel_01.jpg' );
	[ points2, A, B, C, R ] = harris( img2 );
	
	binsize = 3;
	thres = 0.9;
	
	[ r, c, A, A_t ] = hough2d( img1, points1, img2, points2, binsize, thres );
	figure, imshow( img2 ), title( 'hough2d' );
	hold on;
	
	s = size( r );
	
	for i = 1:1:s(1)
        draw_bb( img1, r( i, 1 ), c( i, 1 ) );
    end
end