function [ E, Z, M ] = gdlog( I, s )
    % Η συνάρτηση πραγματοποιεί ανίχνευση ακμών στην εικόνας εισόδου I, με συνδυασμό των μεθόδων
    % Gaussian derivative και Laplacian of Gaussian, όπου s είναι η τυπική απόκλιση των αντίστοιχων
    % φίλτρων.
    
    I = im2double( I );
    % 2D Gaussian derivative
    K = 31;
    vk = ( 0 : K - 1 ) - ( K - 1 ) / 2;
    [ u, v ] = meshgrid( vk, vk );
    G = 1 / ( 2 * pi * s ^ 2 ) * exp( -( u .^ 2 + v .^ 2) / ( 2 * s ^ 2 ) );
    Gu = -( u / s ^ 2 ) .* G;
    Gv = -( v / s ^ 2 ) .* G;
    Gx = imfilter( I, Gu, 'replicate', 'conv' );
    Gy = imfilter( I, Gv, 'replicate', 'conv' );
    Gm = sqrt( Gx .^ 2 + Gy .^ 2 );
    M = Gm;
    
    % 2D Laplacian of Gaussian
    L = fspecial( 'log', 31, 5 );
    Glm = imfilter( I, L, 'replicate' );
    % Κατωφλίωση στο 0.
    BW = im2bw( Glm, 0 );
    Z = bwperim( BW, 8 );
    
    E = M .* Z;
end