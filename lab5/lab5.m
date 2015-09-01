function [] = lab5()
	% ������� ���������� �� 03109004, ����� �������.
	
    I1 = imread( 'house1.jpg' );
	points = harris_laplace( I1 );
	draw_points( I1, points );
	
	I2 = imread( 'house2.jpg' );
	I2 = imrotate( I2, 35 );
	I2 = imcrop( I2, [250 250 100 150] );	% Crop ��� ������� 250:400 ��� ��� ������ 250:350.
	points = harris_laplace( I2 );
	draw_points( I2, points );
end