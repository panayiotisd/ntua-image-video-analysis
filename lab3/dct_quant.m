function [Q_Y, Q_Cb, Q_Cr] = dct_quant( I, q )
    % Συνάρτηση για κωδικοποίηση με χρήση DCT σε 8x8 blocks της εικόνας με κβαντοποίηση και ακέραια διαίρεση.
    
    RGB = im2double( I );
    YCbCr = ( rgb2ycbcr( RGB ) ); % RGB -> YCbCr
    Y = YCbCr( :,:,1 ); % Y Channel
    Cb = YCbCr( :,:,2 ); % Cb Channel
    Cr = YCbCr( :,:,3 ); % Cr Channel
    
    % Εφαρμογή 2D DCT σε µη επικαλυπτόµενα 8x8 block κάθε καναλιού της YCbCr εικόνας.
    Db_Y = blkproc( Y, [8 8], 'dct2' );
    Db_Cb = blkproc( Cb, [8 8], 'dct2' );
    Db_Cr = blkproc( Cr, [8 8], 'dct2' );
    
    % Πολλαπλασιασμός με 255 για να εφαρμοστεί σωστά η quant_Y και quant_C στην συνέχεια.
    Db_Y = Db_Y .* 255;
    Db_Cb = Db_Cb .* 255;
    Db_Cr = Db_Cr .* 255;
    
    % Εφαρμογή των συναρτήσεων κβάντισης σε blocks των καναλιών.
    Q_Y = blkproc( Db_Y, [8 8], 'quant_Y', q );
    Q_Cb = blkproc( Db_Cb, [8 8], 'quant_C', q );
    Q_Cr = blkproc( Db_Cr, [8 8], 'quant_C', q );
end