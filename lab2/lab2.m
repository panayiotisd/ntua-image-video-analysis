function [] = lab2()
    % Φόρτωση εικόνας.
    I = imread( 'house.tif' );
    
    y_0 = [];
    y_G = [];
    y_S = [];
    
    % Apply noise and filters
    for s = 0.01:0.02:2
        [SNR_0, SNR_G, SNR_S] = denoise( I, s );
        y_0 = [ y_0 SNR_0 ];
        y_G = [ y_G SNR_G ];
        y_S = [ y_S SNR_S ]; 
    end
    
    x = y_0;
    
    % Εμφάνιση αποτελεσμάτων.
    plot( x, y_0, 'blue' );
    xlabel('SNR_0');
    ylabel('SNR_0 = blue , SNR_G = green , SNR_S = red');
    hold all
    plot( x, y_G, 'green' );
    hold all
    plot( x, y_S, 'red' );
end