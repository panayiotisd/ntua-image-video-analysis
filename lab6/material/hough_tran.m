function Acc = hough_tran(I, K)

I = rot90(I, -1);

if(nargin < 2), K = [240 240]; end
K_t = K(1);
K_r = K(2);

Acc = zeros(K_t, K_r);

[M,N] = size(I);
r_max = .5 * sqrt(M^2 + N^2);

p = 0; % p = .3843;
vt = (p + (0:K_t-1)) / K_t * pi;

cos_vt = cos(vt);
sin_vt = sin(vt);

uc = (1+M)/2;
vc = (1+N)/2;

for u = 1:M
	for v = 1:N
		E = I(u,v);
		if(E)
			x = u - uc;
			y = v - vc;
			vr = x * cos_vt + y * sin_vt;
			vr = round((vr + r_max) * (K_r-1)/(2*r_max) + 1);
			for t = 1:K_t
				r = vr(t);
				Acc(t,r) = Acc(t,r) + E;
			end
		end
	end
end

Acc = rot90(Acc / max(Acc(:)));


