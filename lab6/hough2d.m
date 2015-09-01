function [ r, c, A, A_t ] = hough2d( img1, p1, img2, p2, binsize, thres )
	%� ��������� �������� �� ����������� �������������� Hough ��� ��������� ������������. ������� �� ������:
	%	img1 : ������-�������   ���   ������������   ����   ��   �����������   ��   �����   �� ������������
	%	p1 : ������ ������������� ��� ������� img1
	%	img2 : ������ ���� ����� ���������� �� ������������ �� �����������
	%	p2 : ������ ������������� ��� ������� img2
	%	binsize : ������� �� pixel ��� ���� bin ��� ������ ����������� A (�.�. 3, 5, �)
	%	thres : ������� ��� �� ����������� ���� A (�.�. 0.9).
	%���  ����������  ���  ������  r,  c (������, �����) ��� ������� �������� ��� ������� ������������� ��� �������.
	
	[ x1, y1, z1 ] = size( img1 );
	[ x2, y2, z2 ] = size( img2 );
	
	A = zeros( ceil( (x1 + x2) / binsize ), ceil( (y1 + y2) / binsize ) );
	
	xc = ceil( x1 / 2 );
	yc = ceil( y1 / 2 );
	
	[ n1, m1 ] = size( p1 );
	[ n2, m2 ] = size( p2 );
	
	for j = 1:1:n2
        for i = 1:1:n1
			xcord = ( p2( j, 1 ) - p1( i, 1 ) + xc ) + ( x1 / 2 );
			ycord = ( p2( j, 2 ) - p1( i, 2 ) + yc ) + ( y1 / 2 );
			
			xcord = ceil( xcord / binsize );
			ycord = ceil( ycord / binsize );
			A( xcord, ycord ) = A( xcord, ycord ) + 1;
		end
    end
	
	threshold = ( thres * max( max( A ) ) );
	A_t = A .* ( A >= threshold );

	[ r, c, mx ] = local_max( A_t );
	r = r .* binsize - xc;
	c = c .* binsize - yc;
end