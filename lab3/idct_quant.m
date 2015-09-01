function [SNR_Dq, CR_Dq] = idct_quant( Q_Y, Q_Cb, Q_Cr, I, q )
    % Συνάρτηση για αποκωδικοποίηση με χρήση DCT σε 8x8 blocks της εικόνας με κβαντοποίηση και ακέραια διαίρεση και υπολογισμό SNR και CR.
    
    Q_Y = blkproc( Q_Y, [8 8], 'iquant_Y', q );
    Q_Cb = blkproc( Q_Cb, [8 8], 'iquant_C', q );
    Q_Cr = blkproc( Q_Cr, [8 8], 'iquant_C', q );
    
    % Διαίρεση με 255 για να επιστρέψουμε στο 0..1 (καθώς είχαμε πολλαπλασιάσει με 255 για να εφαρμόσουμε σωστά τις quant_Y, quant_C και iquant_Y, iquant_C).
    Q_Y = Q_Y ./ 255;
    Q_Cb = Q_Cb ./ 255;
    Q_Cr = Q_Cr ./ 255;
    
    iQ_Y = blkproc( Q_Y, [8 8], 'idct2' );
    iQ_Cb = blkproc( Q_Cb, [8 8], 'idct2' );
    iQ_Cr = blkproc( Q_Cr, [8 8], 'idct2' );
    
    iQ_Y = abs( iQ_Y );
    iQ_Cb = abs( iQ_Cb );
    iQ_Cr = abs( iQ_Cr );    
    
    iYCbCr(:,:,1) = iQ_Y;
    iYCbCr(:,:,2) = iQ_Cb;
    iYCbCr(:,:,3) = iQ_Cr;
    iRGB = ycbcr2rgb(iYCbCr);
    %figure, imshow(iRGB);
    
    I = im2double( I );
    SNR_Dq = snr( I, iRGB );
    
    [ n, m ] = size( Q_Y );
    counter = 0;
    for i = 1:1:n
        for j = 1:1:m
            if Q_Y( i, j ) ~= 0
                counter = counter + 1;
            end
            if Q_Cb( i, j ) ~= 0
                counter = counter + 1;
            end
            if Q_Cr( i, j ) ~= 0
                counter = counter + 1;
            end
        end
    end
    
    sizeUncompressed = n * m * 3;
    sizeCompressed = counter;
    CR_Dq = sizeUncompressed / sizeCompressed;
end