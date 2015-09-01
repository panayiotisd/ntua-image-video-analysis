function J = freqfilt( I, h )
    % Η συνάρτηση φιλτράρει την εικόνα I με το φίλτρο h.
    I = im2double( I );
    [M, N] = size( I );
    F = fft2( I, M+10, N+10 );
    H = fft2( h, M+10, N+10 );
    JF = abs( ifft2( F.*H ) );
    JF = JF( 6:end-5, 6:end-5 );
    J = JF;
end