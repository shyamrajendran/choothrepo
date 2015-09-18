i = imread('46.jpg');  
%use additional i=rgb2gray(i) if your image is not grayscale
b=4;w=251;  %assuming our black pixel is having a value of '4' & the white one is '251'
img_with_noise= i; 
%preserving the original image 'i' & operating on a new variable
[m,n]=size(i); %getting the size of image
x = randi([0,255],m,n);  % **See below note
%generating a random matrix of size mxn which is the size of image 
%whose value of each element is randomly distributed 
%over a range of 0 to 255
img_with_noise(x <= b) = 0;  
%setting that pixel value '0' whose pixel value is below or equal '4'
%this step will add the pepper noise in the image

 img_with_noise(x >=w) = 255;  
%setting that pixel value to '255' whose pixel value is >= '251'
%this step will add the salt noise in the image 
imshow(img_with_noise)

f = img_with_noise;

filter2 = zeros(7);
filter2(4,4) = 0.60;
filter2(4,5) = 0.50; filter2(4,3)  = 0.50; filter2(3,4) = 0.50; filter2(5,4) = 0.50;
filter2(3,3) = 0.40; filter2(3,5)  = 0.40; filter2(5,3) = 0.40; filter2(5,5) = 0.40;
filter2(2,4) = 0.25; filter2(4,2)  = 0.25; filter2(4,6) = 0.25; filter2(6,4) = 0.25;
filter2(2,3) = 0.125; filter2(2,5) = 0.125; filter2(3,2) = 0.125; filter2(5,2) = 0.125; filter2(3,6) = 0.125; 
filter2(5,6) = 0.125; filter2(6,3) = 0.125; filter2(6,5) = 0.125;
filter2(2,2) = 0.08;filter2(2,6) = 0.08;filter2(6,2) = 0.08;filter2(6,6) = 0.08;

filter2 = filter2 .* 0.2;    
figure, colormap gray, imagesc(1 - filter2);
r = conv2(double(f(:,:,1)), double(filter2));
g = conv2(double(f(:,:,2)), double(filter2));
b = conv2(double(f(:,:,3)), double(filter2));

K = cat(3, uint8(r), uint8(g), uint8(b));
figure, imshow(K);

