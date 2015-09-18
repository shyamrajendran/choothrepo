function lec1()

m = 100; n = 100;
img = imread('udit.jpg');
img1 = imresize(img, [m n]);
imgvec = reshape(img1, m*n*3, 1);
iv = zeros(n);
k = floor(size(iv,1)/2);
j = k;
for i = 1 : k
   iv(i,j+1) = 1;
   j = j+1;
end
j = 1;
for i = k+1:size(iv,1)
    iv(i,j) = 1;
    j = j+1;
end
ih = eye(m);
ih = rot90(ih);
ans1 = kron(ih, iv);
d = diag([1 0 1]);
ans2 = kron(d, ans1);
imgvec = double(imgvec);
final = ans2 * imgvec;
final = uint8(final);
finalimg = reshape(final, m, n, 3);
imshow(finalimg);

end

