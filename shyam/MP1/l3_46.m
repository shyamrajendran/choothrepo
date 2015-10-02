function l3_46()

%% input 
image = imread('46.jpg');
[H,V,P] = size(image);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
  FigHandle = figure;
  set(FigHandle, 'Position', [50, 50, 1800, 500]);


%% For output 3
scale = 0.02;
filterV = horzcat(gen3(20,scale),gen2(20,scale));
subplot(2,6,7);
imagesc(image);
subplot(2,6,8);
imagesc(imcomplement(filterV)),colormap gray;

r = conv2(double(filterV), double(R),'full');
g = conv2(double(filterV), double(G),'full');
b = conv2(double(filterV), double(B),'full');

[h,v,p] = size(r);
out3 = zeros(h,v);
out3(:,:,1) = r;
out3(:,:,2) = g;
out3(:,:,3) = b;
subplot(2,6,9);
imagesc(uint8(out3));
title('out3');


%% for output 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%    out2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
image = imread('46.jpg');
[H,V,P] = size(image);
H
V
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
%   FigHandle = figure;
%   set(FigHandle, 'Position', [50, 50, 1800, 500]);

noisyimage = rand(H,V);
f1 = noisyimage>0.5;

noisyimage = rand(H,V);
f2 = noisyimage>0.5;

noisyimage = rand(H,V);
f3 = noisyimage>0.5;
imagesc(f1);

r = conv2(double(f1), R);
g = conv2(double(f2), G);
b = conv2(double(f3), B);
size(r);
size(g);
size(b);
out2 = zeros(size(r));
out2(:,:,1) = r;
out2(:,:,2) = g;
out2(:,:,3) = b;
% subplot(2,6,4);
figure,imagesc(out2);
out2;
% subplot(2,6,5);
%}

% ratio = 0.4;
% f = noise(7,ratio);
% r = conv2(f, R,'full');
% g = conv2(f, G,'full');
% b = conv2(f, B,'full');
% size(r);
% size(g);
% size(b);
% out2 = zeros(size(r));
% out2(:,:,1) = r;
% out2(:,:,2) = g;
% out2(:,:,3) = b;
% subplot(2,6,6);
% imagesc(out2);
% 
% title('out2');




%% out 4 
image = imread('46.jpg');
[H,V,P] = size(image);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
  FigHandle = figure;
  set(FigHandle, 'Position', [50, 50, 1800, 500]);
f = ones(1,41);
k = 0
for i = 15:25
    f(1,i) = k + k*1.001;
    k = k + k*1.001;
end
f
% generating the middle while image 
r = conv2(double(f), double(R),'full');
g = conv2(double(f), double(G),'full');
b = conv2(double(f), double(B),'full');
size(r);
size(g);
size(b);
out4 = zeros(size(r));
out4(:,:,1) = r;
out4(:,:,2) = g;
out4(:,:,3) = b;
subplot(2,6,10);
imagesc(image);
subplot(2,6,11);
imagesc(f),colormap gray;
subplot(2,6,12)
imagesc(out4);
title('out4');



%%   out1 

n = 24;
f = blur(n);
r = conv2(f, R,'full');
g = conv2(f, G,'full');
b = conv2(f, B,'full');
size(r);
size(g);
size(b);
out1 = zeros(size(r));
out1(:,:,1) = r;
out1(:,:,2) = g;
out1(:,:,3) = b;
subplot(2,6,1);
imagesc(image);
subplot(2,6,2);
imagesc(imcomplement(f)),colormap gray;
subplot(2,6,3)
imagesc(out1)
title('out1');


end
