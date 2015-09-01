function [SNR_Dz, CR_Dz] = idct_zigzag( Z_Y, Z_Cb, Z_Cr, I )
    % Συνάρτηση για αποκωδικοποίηση με χρήση DCT σε 8x8 blocks της εικόνας με zig-zag scanning και υπολογισμό SNR και CR.
    
    iZ_Y = blkproc( Z_Y, [8 8], 'idct2' );
    iZ_Cb = blkproc( Z_Cb, [8 8], 'idct2' );
    iZ_Cr = blkproc( Z_Cr, [8 8], 'idct2' );
    
    iZ_Y = abs( iZ_Y );
    iZ_Cb = abs( iZ_Cb );
    iZ_Cr = abs( iZ_Cr );
    
    iYCbCr( :,:,1 ) = iZ_Y;
    iYCbCr( :,:,2 ) = iZ_Cb;
    iYCbCr( :,:,3 ) = iZ_Cr;
    iRGB = ycbcr2rgb( iYCbCr );
    %figure, imshow( iRGB );
    
    I = im2double( I );
    SNR_Dz = snr( I, iRGB );
    
    [ n, m ] = size( Z_Y );
    counter = 0;
    for i = 1:1:n
        for j = 1:1:m
            if Z_Y( i, j ) ~= 0
                counter = counter + 1;
            end
            if Z_Cb( i, j ) ~= 0
                counter = counter + 1;
            end
            if Z_Cr( i, j ) ~= 0
                counter = counter + 1;
            end
        end
    end
    
    sizeUncompressed = n * m * 3;
    sizeCompressed =  counter;
    CR_Dz = sizeUncompressed / sizeCompressed;
end