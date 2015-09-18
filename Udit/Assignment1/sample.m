originalRGB = imread('46.jpg');
f = imnoise(originalRGB, 'salt & pepper',0.01);
figure, imshow(f)

filter2 = zeros(7);
filter2(4,4) = 1;
filter2(4,5) = 0.75; filter2(4,3)  = 0.75; filter2(3,4) = 0.75; filter2(5,4) = 0.75;
filter2(3,3) = 0.5; filter2(3,5)  = 0.5; filter2(5,3) = 0.5; filter2(5,5) = 0.5;
filter2(2,4) = 0.25; filter2(4,2)  = 0.25; filter2(4,6) = 0.25; filter2(6,4) = 0.25;
filter2(2,3) = 0.125; filter2(2,5) = 0.125; filter2(3,2) = 0.125; filter2(5,2) = 0.125; filter2(3,6) = 0.125; 
filter2(5,6) = 0.125; filter2(6,3) = 0.125; filter2(6,5) = 0.125;
filter2 = filter2 .* 0.2;    
figure, colormap gray, imagesc(filter2);
r = conv2(double(f(:,:,1)), double(filter2));
g = conv2(double(f(:,:,2)), double(filter2));
b = conv2(double(f(:,:,3)), double(filter2));

K = cat(3, uint8(r), uint8(g), uint8(b));
figure, imshow(K);
