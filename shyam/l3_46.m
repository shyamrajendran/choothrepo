function l3_46()

%% input 
image = imread('46.jpg');
[H,V,P] = size(image);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
  FigHandle = figure;
  set(FigHandle, 'Position', [50, 50, 1800, 800]);


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

%{
%% for output 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%    out2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ratio = 0.4;
f = noise(7,ratio);
r = conv2(f, R,'full');
g = conv2(f, G,'full');
b = conv2(f, B,'full');
size(r);
size(g);
size(b);
out2 = zeros(size(r));
out2(:,:,1) = r;
out2(:,:,2) = g;
out2(:,:,3) = b;
subplot(2,6,4);
imagesc(image);
subplot(2,6,5);
imagesc(imcomplement(f)),colormap gray;
subplot(2,6,6);
imagesc(out2);

title('out2');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% out 4 
%%%%%%%%%%%%%%%%

f = zeros(1,41);
f(1,20) = -0.01;
f(1,21) = 0.025;
f(1,22) = -0.01;

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
imagesc(imcomplement(f)),colormap gray;
subplot(2,6,12)
imagesc(out4);
title('out4');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%    out1 TODO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ratio = 0.4;
f = noise(7,ratio);
r = conv2(f, R,'full');
g = conv2(f, G,'full');
b = conv2(f, B,'full');
size(r);
size(g);
size(b);
out2 = zeros(size(r));
out2(:,:,1) = r;
out2(:,:,2) = g;
out2(:,:,3) = b;
subplot(2,6,1);
imagesc(image);
subplot(2,6,2);
imagesc(imcomplement(f)),colormap gray;
% subplot(2,6,3)
% imagesc(out2)

title('out1');
%}

end
