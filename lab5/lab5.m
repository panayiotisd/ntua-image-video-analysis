function [] = lab5()
	% Δανασής Παναγιώτης ΑΜ 03109004, τμήμα Πέμπτης.
	
    I1 = imread( 'house1.jpg' );
	points = harris_laplace( I1 );
	draw_points( I1, points );
	
	I2 = imread( 'house2.jpg' );
	I2 = imrotate( I2, 35 );
	I2 = imcrop( I2, [250 250 100 150] );	% Crop τις γραμμές 250:400 και τις στήλες 250:350.
	points = harris_laplace( I2 );
	draw_points( I2, points );
end