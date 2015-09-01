function [Z_Y, Z_Cb, Z_Cr] = dct_block( I, k_Y, k_C )
    % Συνάρτηση για κωδικοποίηση με χρήση DCT σε 8x8 blocks της εικόνας με zig-zag scanning.
    
    RGB = im2double( I );
    YCbCr = ( rgb2ycbcr( RGB ) ); % RGB -> YCbCr
    Y = YCbCr( :,:,1 ); % Y Channel
    Cb = YCbCr( :,:,2 ); % Cb Channel
    Cr = YCbCr( :,:,3 ); % Cr Channel
    
    % Εφαρμογή 2D DCT σε µη επικαλυπτόµενα 8x8 block κάθε καναλιού της YCbCr εικόνας.
    Db_Y = blkproc( Y, [8 8], 'dct2' );
    Db_Cb = blkproc( Cb, [8 8], 'dct2' );
    Db_Cr = blkproc( Cr, [8 8], 'dct2' );
    
    % Εφαρμογή της συνάρτησης zig-zag σε κάθε κανάλι.
    Z_Y = blkproc( Db_Y, [8 8], 'zigzag', k_Y );
    Z_Cb = blkproc( Db_Cb, [8 8], 'zigzag', k_C );
    Z_Cr = blkproc( Db_Cr, [8 8], 'zigzag', k_C );
end