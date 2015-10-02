function main()

%% clear 
close all;
clc;

%% lecture 1 - Slide 47
my_image = uint8(imread('shyam.jpg'));
FigHandle = figure('name','lecture 1 - 47','numbertitle','off');
subplot(2,2,1);
imshow(my_image);
title('input');
image_resized = double(imresize(my_image,[50 50]));

[H,V,P] = size(image_resized);
HH = gen2(H,1);


subplot(2,2,2);
imshow(HH);


VV = gen(V,1);


subplot(2,2,3);
imshow(VV);


diagI = diag([1,0,1]);

% kronValue = kron(kron(diagI,HH),VV);
kronValueHHVV = kron(HH,VV);
kronValue = kron(diagI,kronValueHHVV);

vec_image = image_resized(:);
final_vec = uint8(kronValue*vec_image);
final_image = reshape(final_vec,H,V,P);

subplot(2,2,4);
imshow(final_image);
title('lecture 1 - Slide 47 output');


%% lecture 3 - Slide 18
input = '18.wav';
list = [64,512,2048];
FigHandle = figure('name','lecture 3 - 18','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 2000, 1000]);

i = 1;
for windowSize = list
    [output, samples, sampleRate] = my_spectograph(input, windowSize);
    T = 0 : (windowSize*1/sampleRate) : (length(samples)*1/sampleRate) - windowSize*1/sampleRate;
    F = 0 : sampleRate/2;
    increments = size(samples)/windowSize;
    subplot(3,1,i);
    colormap gray,imagesc(T,F,imcomplement(output));
    view(0,90);
    axis xy; axis tight;
    xlabel('Time (sec)');
    ylabel('Frequency (Hz)');
    str = sprintf('Window, N = %d ',windowSize);
    title(str);
    i = i + 1;
end

%% lecture 3 - Slide 21
N = 32;
[X, Y]= meshgrid(2*pi*(1:N)/N, 2*pi*(1:N)/N);

o1 = sin(3*X);
o2 = sin(5*Y);
o3 = sin(3*(X+Y));
o4 = sin(3*(X+Y)) + sin(6*X + 8*Y);
FigHandle = figure('name','lecture 3 - 21','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 2000, 1000]);

subplot(2,4,1)
imagesc(imcomplement(o1)),colormap gray, title(' sin(3*X)');
subplot(2,4,3)
imagesc(imcomplement(o2)),colormap gray,title(' sin(5*Y)');
subplot(2,4,5)
imagesc(imcomplement(o3)),colormap gray,title(' sin(3*(X+Y))');
subplot(2,4,7)
imagesc(imcomplement(o4)),colormap gray,title(' sin(3*(X+Y)) + sin(6*X+8*Y)');

f = mydft(N);
oo1 = f * o1 * f;
subplot(2,4,2)
imagesc(imcomplement(abs(oo1))),colormap gray, title(' sin(3*X)');



t = o2*mydft(N);
oo2 = mydft(N)*t;
subplot(2,4,4)
imagesc(imcomplement(abs(oo2))),colormap gray, title(' sin(5*Y)');

t = o3*mydft(N);
oo3 = mydft(N)*t;
subplot(2,4,6)
imagesc(imcomplement(abs(oo3))),colormap gray, title(' sin(3*(X+Y))');


t = o4*mydft(N);
oo4 = mydft(N)*t;
subplot(2,4,8)
imagesc(imcomplement(abs(oo4))),colormap gray, title(' sin(3*(X+Y)) + sin(6*X+8*Y)');

%% lecture 3 - Slide 39
input = '39.wav';
windowSize = 512;
order = 20;
[output, samples, sampleRate] =  my_spectograph(input, windowSize);
T = 0 : (windowSize*1/sampleRate) : (length(samples)*1/sampleRate) - windowSize*1/sampleRate;
F = 0 : sampleRate/2;

filter = fir1(order, 0.8, 'high');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);

FigHandle = figure('name','lecture 3 - 39','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 2000, 1000]);

filter = fir1(order, 0.9, 'low');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,1)
imagesc(T,F,imcomplement(output)),colormap gray
view(0,90);axis xy; axis tight;
title('lowpass');
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

filter = fir1(order, [0.2 0.8], 'bandpass');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,3)
imagesc(T,F,imcomplement(output)),colormap gray
view(0,90);axis xy; axis tight;
title('bandpass');
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

filter = fir1(order, 0.8, 'high');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,2)
imagesc(T,F,imcomplement(output)),colormap gray;
view(0,90);axis xy; axis tight;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('high');



filter = fir1(order, [0.2 0.4], 'stop');
samplesFiltered = conv(samples,filter);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,4)
imagesc(T,F,imcomplement(output)),colormap gray
view(0,90);axis xy; axis tight;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('band reject');
%% lecture 3 - Slide 46
image = imread('46.jpg');
[H,V,P] = size(image);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
FigHandle = figure('name','lecture 3 - 46','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1800, 500]);


n = 25;
f = blur(n);
r = conv2(double(R), double(f));
g = conv2(double(G), double(f));
b = conv2(double(B), double(f));
out1(:,:,1) = uint8(r);
out1(:,:,2) = uint8(g);
out1(:,:,3) = uint8(b);
subplot(2,6,1);
imagesc(image);
subplot(2,6,2);
imagesc(imcomplement(f)),colormap gray;
subplot(2,6,3)
imagesc(uint8(out1));
title('out1');


noisyimage = rand(H,V);
f1 = noisyimage>0.4;

noisyimage = rand(H,V);
f2 = noisyimage>0.3;

noisyimage = rand(H,V);
f3 = noisyimage>0.3;

[h,v,p ] = size(f1);
for i = 1:h
    for j = 1:v
        if (f1(i,j) == 0)
            R(i,j) = 100;
        end
        if (f2(i,j) == 0)
            G(i,j) = 100;
        end
        if (f3(i,j) == 0)
            B(i,j) = 100;
        end
    end
end


% construct input image
in2(:,:,1) = R;
in2(:,:,2) = G;
in2(:,:,3) = B;

subplot(2,6,4);
imagesc(uint8(in2));
subplot(2,6,5);


scale = 0.6;
f = noise(7,scale);
imagesc(imcomplement(f)),colormap gray;
r = conv2(double(f), double(R),'full');
g = conv2(double(f), double(G),'full');
b = conv2(double(f), double(B),'full');
out2(:,:,1) = r;
out2(:,:,2) = g;
out2(:,:,3) = b;
subplot(2,6,6);
imagesc(uint8(out2));
title('out2');



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



image = imread('46.jpg');
[H,V,P] = size(image);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

in4 = image;

zerofilter = zeros(1,531);
k = 2;
for i = 265 : -1 : 1
     in4(:,i,:) = in4(:,i,:) * k;
     zerofilter(1,i) = k;
     k = k - 0.005;
end


k = 2;
for i = 266 : 531
     in4(:,i,:) = in4(:,i,:) * k;
     zerofilter(1,i) = k;
     k = k - 0.005;
end
% imagesc(zerofilter),title('Filter to whiten center of the image');
filter = zeros(1,41);
filter(1,21) = 1.0;
filter(1,20) = -0.2;
filter(1,22) = -0.2;

r = conv2(double(in4(:,:,1)), double(filter));
g = conv2(double(in4(:,:,2)), double(filter));
b = conv2(double(in4(:,:,3)), double(filter));
filteredImg = cat(3, uint8(r), uint8(g), uint8(b));

subplot(2,6,10);
imagesc(in4);
subplot(2,6,11),colormap gray;

plot(filter);
axis([0 41 -0.2 1.2]);
subplot(2,6,12);
imagesc(filteredImg);
title('out4');

%% lecture 3 - slide 49
input = '49.mp3';
downSampleRate = 8;
windowSize = 512;

[output, samples, sampleRate] = my_spectograph(input, windowSize);

T = 0 : (windowSize*1/sampleRate) : (length(samples)*1/sampleRate) - windowSize*1/sampleRate;
F = 0 : sampleRate/2;

increments = size(samples)/windowSize;
x = 1:increments:size(samples);
y = log(linspace(1, 12000,5));


FigHandle = figure('name','lecture 3 - 49','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 800]);
subplot(3,1,1)
% imagesc([1 6],y, imcomplement(output)), colormap gray;
imagesc(T, F,imcomplement(output));
view(0,90);
axis xy; axis tight;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

str = sprintf('Spectrogram for input with WindowSize = %d ',windowSize);
title(str);


sizeSample = size(samples);
rows = uint8(sizeSample/downSampleRate);
ovector = zeros(1,1);
j = 1;
for i = 1:downSampleRate:sizeSample;
    ovector(j,1) = samples(i,1);
    j = j+1;
end
increments = size(ovector)/windowSize;
x = 1:increments:size(ovector);
y = log(linspace(1, 4000,5));
output = my_specHelper(ovector, sampleRate, windowSize);
subplot(3,1,2)
% colormap gray,imagesc(x,y,1-output);

colormap gray,imagesc(T, F,imcomplement(output));
view(0,90);
axis xy; axis tight;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
str = sprintf('Spectogram  aliasing seen for WindowSize = %d with M = 8',windowSize);
title(str);
   
order = 5;
filter = fir1(order, 0.4, 'low');
ovector = conv(filter, ovector);

increments = size(ovector)/windowSize;
x = 1:increments:size(ovector);
y = log(linspace(1, 4000,5));
output = my_specHelper(ovector, sampleRate, windowSize);
% figure,colormap gray,imagesc(x,y,imcomplement(output));
subplot(3,1,3)
colormap gray,imagesc(T, F, imcomplement(output));
view(0,90);
axis xy; axis tight;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
str = sprintf('Spectogram  aliasing removed when passed through low pass filter ');
title(str);

%% lecture 4 - slide 50
f = zeros(3);
f(:) = -1/8;
f(2,2) = 1;

input = zeros(50,50);
for i = 15:35
    for j = 15:35
        input(i,j) = 1;
    end
end
FigHandle = figure('name','Lecture 4 - 50','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 500, 500]);
subplot(2,2,3)
imshow(input),colormap gray
title('input');
output = conv2(input,f,'full');
subplot(2,2,4)
imshow(output), colormap gray
title('Energy of edge detector');


input = ones(50,50);
for i = 15:35
    for j = 15:35
        input(i,j) = 0;
    end
end
subplot(2,2,1)
imshow(input),colormap gray
title('input');
output = conv2(input,f,'valid');
subplot(2,2,2)
imshow(output),colormap gray
title('Energy of edge detector');

%% lecture 4 - slide 52
image = imread('52.png');
[H,V,P] = size(image)
% image = imresize(image,0.5);
FigHandle = figure('name','lecture 4 - 52','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1200, 600]);

f = zeros(200,200);


for i = 50:150
    f(i,100) = 1;
end

for i = 52:148
    f(i,101) = 1;
    f(i,101) = 1;
end
for i = 54:146
    f(i,102) = 1;
    f(i,102) = 1;
end
for i = 60:140
    f(i,103) = 1;
    f(i,103) = 1;
end

f1 = fliplr(f);
f1 = f + f1;
f2 = rot90(f1,1);
f3 = imrotate(f1, 45);
f4 = imrotate(f1, -45);

o1=conv2(f1, image,'full');
o2=conv2(f2, image,'full');
o3=conv2(f3, image,'full');
o4=conv2(f4, image,'full');


subplot(2,5,2),colormap gray, imagesc(f1), title('0 filter');
subplot(2,5,3),colormap gray, imagesc(f2);title('90 filter');
subplot(2,5,4),colormap gray, imagesc(f3);title('45 filter');
subplot(2,5,5),colormap gray, imagesc(f4);title('-45 filter');
subplot(2,5,6),colormap gray, imagesc(image);title('input');
subplot(2,5,7),colormap gray, imagesc(o1);title('0 response');
subplot(2,5,8),colormap gray, imagesc(o2);title('90 filter');
subplot(2,5,9),colormap gray, imagesc(o3);title('45 filter');
subplot(2,5,10),colormap gray, imagesc(o4);title('-45 filter');
end
