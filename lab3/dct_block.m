function [Z_Y, Z_Cb, Z_Cr] = dct_block( I, k_Y, k_C )
    % ��������� ��� ������������ �� ����� DCT �� 8x8 blocks ��� ������� �� zig-zag scanning.
    
    RGB = im2double( I );
    YCbCr = ( rgb2ycbcr( RGB ) ); % RGB -> YCbCr
    Y = YCbCr( :,:,1 ); % Y Channel
    Cb = YCbCr( :,:,2 ); % Cb Channel
    Cr = YCbCr( :,:,3 ); % Cr Channel
    
    % �������� 2D DCT �� �� �������������� 8x8 block ���� �������� ��� YCbCr �������.
    Db_Y = blkproc( Y, [8 8], 'dct2' );
    Db_Cb = blkproc( Cb, [8 8], 'dct2' );
    Db_Cr = blkproc( Cr, [8 8], 'dct2' );
    
    % �������� ��� ���������� zig-zag �� ���� ������.
    Z_Y = blkproc( Db_Y, [8 8], 'zigzag', k_Y );
    Z_Cb = blkproc( Db_Cb, [8 8], 'zigzag', k_C );
    Z_Cr = blkproc( Db_Cr, [8 8], 'zigzag', k_C );
end