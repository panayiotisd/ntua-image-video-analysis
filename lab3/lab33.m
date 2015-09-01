function [] = lab33()
    k_Y = 12;
    k_C = 8;
    q = 3;
    I = imread( 'flowers.tif' );
    
    [Z_Y, Z_Cb, Z_Cr] = dct_block( I, k_Y, k_C );
    [SNR_Dz, CR_Dz] = idct_zigzag( Z_Y, Z_Cb, Z_Cr, I );
    
    [Q_Y, Q_Cb, Q_Cr] = dct_quant( I, q );
    [SNR_Dq, CR_Dq] = idct_quant( Q_Y, Q_Cb, Q_Cr, I, q );
    
    disp( 'SNR_Dz:' );
    disp( SNR_Dz );
    disp( 'CR_Dz:' );
    disp( CR_Dz );
    disp( 'SNR_Dq:' );
    disp( SNR_Dq );
    disp( 'CR_Dq:' );
    disp( CR_Dq );
end