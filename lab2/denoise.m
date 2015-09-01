function [SNR_0, SNR_G, SNR_S] = denoise( I, s )
    % �������� �������.
    I = im2double( I );
    J = imnoise( I, 'gaussian', 0, (s^2) );
    
    % ���������� ����� 2-D ������� Gaussian �� �=2.
    hg = fspecial( 'gaussian', 11, 2 );
    
    % ���������� ����������� �������.
    [f1,f2] = freqspace( 11, 'meshgrid' );
    Hd = zeros( 11 );
    Hd( sqrt( f1.^2 + f2.^2 ) < 0.5 ) = 1;
    hl = fsamp2( Hd );
    
    % �������� �������.
    Jg = freqfilt( J, hg );
    Jl = freqfilt( J, hl );
    
    % ����������� snr.
    SNR_0 = snr( I, J );
    SNR_G = snr( I, Jg );
    SNR_S = snr( I, Jl );
end