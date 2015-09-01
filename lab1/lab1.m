function [] = lab1()
    % Load image
    I = imread( 'board.tif' );
    I = im2double( I );
    I = rgb2gray( I );
    
    % Apply noise and filters
    Noisy = imnoise( I, 'salt & pepper', 0.15 );
    Med = medfilt2( Noisy, [5 5] );
    AdpM = adpmedian( Noisy, 7 );
    
    % Cropping
    I_C = imcrop( I, [10 200 50 50] );
    Noisy_C = imcrop( Noisy, [10 200 50 50] );
    Med_C = imcrop( Med, [10 200 50 50] );
    AdpM_C = imcrop( AdpM, [10 200 50 50] );
    
    % Resizing
    I_C_R = imresize( I_C, 10, 'nearest' );
    Noisy_C_R = imresize( Noisy_C, 10, 'nearest' );
    Med_C_R = imresize( Med_C, 10, 'nearest' );
    AdpM_C_R = imresize( AdpM_C, 10, 'nearest' );
    
    % Display results
    figure, imshow( I_C_R ), title( 'Original' )
    figure, imshow( Noisy_C_R ), title( 'Salt-n-pepper' )
    figure, imshow( Med_C_R ), title( 'Median' )
    figure, imshow( AdpM_C_R ), title( 'Adaptive Median' )
    
    % Compute and display snr
    snr_sp = snr( I, Noisy );
    snr_Median = snr( I, Med );
    snr_AdpMedian = snr( I, AdpM );
    
    disp( 'SNR with s&p:' );
    disp( snr_sp );
    disp( 'SNR with median filtering:' );
    disp( snr_Median );
    disp( 'SNR with adaptive median filtering:' );
    disp( snr_AdpMedian );
end