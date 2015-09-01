function [] = lab3()
    I = imread( 'flowers.tif' );
    
    dzSnr = [];
    dzLambda = [];
    
    dqSnr = [];
    dqLambda = [];
        
    for k_Y = 2:1:20
        [Z_Y, Z_Cb, Z_Cr] = dct_block( I, k_Y, ( k_Y / 2 ) );
        [SNR_Dz, CR_Dz] = idct_zigzag( Z_Y, Z_Cb, Z_Cr, I );
        dzSnr = [ dzSnr SNR_Dz ];
        dzLambda = [ dzLambda ( 1 / CR_Dz ) ];
    end
    for q = 0.2:1:16
        [Q_Y, Q_Cb, Q_Cr] = dct_quant( I, q );
        [SNR_Dq, CR_Dq] = idct_quant( Q_Y, Q_Cb, Q_Cr, I, q );
        dqSnr = [ dqSnr SNR_Dq ];
        dqLambda = [ dqLambda ( 1 / CR_Dq ) ];
    end
    
    % Εμφάνιση αποτελεσμάτων.
    plot( dzLambda, dzSnr, 'red' );
    hold all;
    plot( dqLambda, dqSnr, 'blue' );
    xlabel( 'λ' );
    ylabel( 'SNR' );
    hleg1 = legend( 'SNR_Dz / λ_Dz','SNR_Dq / λ_Dq' );
    set( hleg1, 'Location', 'NorthWest' );
    set( hleg1, 'Interpreter', 'none' );
end