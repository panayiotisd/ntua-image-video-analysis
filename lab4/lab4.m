function [] = lab3()
	% ������� ���������� �� 03109004, ����� �������.
    I = imread( 'building.tif' );
    
    s = 3;
    [ E, Z, M ] = gdlog( I, s );
    
    % Display results
    figure, imshow( I ), title( 'Original' )
    figure, grayshow( M ), title( '����� M' )
    figure, grayshow( Z ), title( 'zero crossings Z' )
    figure, grayshow( E ), title( '����� E' )
end