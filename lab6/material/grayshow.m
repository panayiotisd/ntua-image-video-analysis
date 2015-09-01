function grayshow(I)

I = double(I);
mx = max(max(I));
mn = min(min(I));
I = (I - mn) ./ (mx - mn);
imshow(I)