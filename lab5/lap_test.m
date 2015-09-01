function scale = lap_test(s)

N = 63; [x,y] = freqspace(N, 'meshgrid');
D = .1 * ones(N, N); D(sqrt(x.^2 + y.^2) < 0.15 * s) = .9;
G = fspecial('gaussian', floor(6*s+1), s); D = imfilter(D, G, 'replicate');
I = D; 

[lap, s_array] = laplace(I, 1.1, 40);
lap_center = lap((N+1)/2, (N+1)/2, :);

figure, imshow(I)
figure, semilogx(s_array, lap_center(:)), grid

[mx, pos] = max(lap_center);
scale = s_array(min(pos));