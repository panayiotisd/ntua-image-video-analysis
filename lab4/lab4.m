function [] = lab3()
	% Δανασής Παναγιώτης ΑΜ 03109004, τμήμα Πέμπτης.
    I = imread( 'building.tif' );
    
    s = 3;
    [ E, Z, M ] = gdlog( I, s );
    
    % Display results
    figure, imshow( I ), title( 'Original' )
    figure, grayshow( M ), title( 'Μέτρο M' )
    figure, grayshow( Z ), title( 'zero crossings Z' )
    figure, grayshow( E ), title( 'Ακμές E' )
end