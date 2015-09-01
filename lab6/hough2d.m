function [ r, c, A, A_t ] = hough2d( img1, p1, img2, p2, binsize, thres )
	%Η συνάρτηση υλοποιεί το γενικευμένο μετασχηματισμό Hough για ανίχνευση αντικειμένων. Παίρνει ως είσοδο:
	%	img1 : εικόνα-μοντέλο   που   περιλαμβάνει   μόνο   το   αντικείμενο   το   οποίο   θα ανιχνεύσουμε
	%	p1 : σημεία ενδιαφέροντος της εικόνας img1
	%	img2 : εικόνα στην οποία επιθυμούμε να ανιχνεύσουμε το αντικείμενο
	%	p2 : σημεία ενδιαφέροντος της εικόνας img2
	%	binsize : μέγεθος σε pixel του κάθε bin του πίνακα συσσώρευσης A (π.χ. 3, 5, …)
	%	thres : κατώφλι που θα εφαρμόσουμε στον A (π.χ. 0.9).
	%και  υπολογίζει  τις  θέσεις  r,  c (γραμμή, στήλη) των τοπικών μεγίστων στο σύστημα συντεταγμένων της εικόνας.
	
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