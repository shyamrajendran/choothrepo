function main()

%% Lecture 1
m = 80; n = 80;
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
imagesc(finalimg);

%% Lecture 3 - Slide 18

[x, fs] = audioread('18.wav');

window = 64;
[S, T, F] = myspectrogram(x, fs, window);
figure('name',strcat('Spectogram : Window Size - ', int2str(window)),'numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

window = 512;
[S, T, F] = myspectrogram(x, fs, window);
figure('name',strcat('Spectogram : Window Size - ', int2str(window)),'numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

window = 2048;
[S, T, F] = myspectrogram(x, fs, window);
figure('name',strcat('Spectogram : Window Size - ', int2str(window)),'numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

%% Lecture 3 - Slide 21

t = 2*pi*(1:32)/32;
x = zeros(size(t,2),size(t,2));
y = zeros(size(t,2),size(t,2));
for i = 1 : size(t,2)
    x(i,:) = t;
end

for i = 1 : size(t,2)
    y(:,i) = t;
end    

F = dft_matrix(size(t,2));
A = 1;

i1 = A * sin(3 * x);
i1 = abs(F * i1 * F);
figure
colormap gray
imagesc(1 - i1);

i2 = A * sin(5 * y);
i2 = abs(F * i2 * F);
figure
colormap gray
imagesc(1 - i2);

i3 = A * sin(3 * x + 3 * y);
i3 = abs(F * i3 * F);
figure
colormap gray
imagesc(1 - i3);

i4 = A * (sin(3*x + 3*y) + sin(6*x + 8*y));
i4 = abs(F * i4 * F);
figure
colormap gray
imagesc(1 - i4);

%% Lecture 3 - Slide 39

[x, fs] = audioread('39.wav');
window = 512;
[S, T, F] = myspectrogram(x,fs,window);
figure('name','Actual Signal Spectogram','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

order = 50;

low_pass_filter = fir1(order, 0.5);
img = conv(x,low_pass_filter);

[S, T, F] = myspectrogram(img,fs,window);
figure('name','Low pass filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

high_pass_filter = fir1(order, 0.3, 'high');
img = conv(x,high_pass_filter);
[S, T, F] = myspectrogram(img,fs,window);
figure('name','High pass filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

band_pass_filter = fir1(order, [0.3 0.6]);
img = conv(x,band_pass_filter);
[S, T, F] = myspectrogram(img,fs,window);
figure('name','Band pass filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

band_reject_filter = fir1(order, [0.3 0.6],'stop');
img = conv(x,band_reject_filter);
[S, T, F] = myspectrogram(img,fs,window);
figure('name','Band reject filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

%% Lecture 3 - Slide 46

originalRGB = imread('46.jpg');

%%%%% filter 1 %%%%%%
filter1 = zeros(25);
factor = 100;

k = 1;
for j = 13 : -1 : 4
    filter1(j,13) = k / factor;
    
    for i = 14 : 21
        filter1(j, i) = (1 - ((i-13)*0.1)) * k / factor;
    end

    for i = 4 : 12
        filter1(j, i) = (1 - ((13-i)*0.1)) * k / factor;
    end
    
    k = k - 0.1;
end

filter12 = rot90(rot90(filter1));
filter12 = filter12((14 : 25), :);

filter1((14:25), :) = filter12; 
filteredImg = ApplyFilter(originalRGB, filter1);

figure 
colormap gray
subplot(1,3,1);
imshow(originalRGB);
subplot(1,3,2);
imshow(1 - filter1, 'DisplayRange', [(1-1/factor) 1]);
subplot(1,3,3);
imshow(filteredImg);

%%%%% filter 2 %%%%%%
b=4;w=251;
img_with_noise= originalRGB; 
[m,n]=size(img_with_noise);
x = randi([0,255],m,n); 
img_with_noise(x <= b) = 0;  
img_with_noise(x >=w) = 255; 

filter2 = zeros(7);
filter2(4,4) = 0.60;
filter2(4,5) = 0.50; filter2(4,3)  = 0.50; filter2(3,4) = 0.50; filter2(5,4) = 0.50;
filter2(3,3) = 0.40; filter2(3,5)  = 0.40; filter2(5,3) = 0.40; filter2(5,5) = 0.40;
filter2(2,4) = 0.25; filter2(4,2)  = 0.25; filter2(4,6) = 0.25; filter2(6,4) = 0.25;
filter2(2,3) = 0.125; filter2(2,5) = 0.125; filter2(3,2) = 0.125; filter2(5,2) = 0.125; filter2(3,6) = 0.125; 
filter2(5,6) = 0.125; filter2(6,3) = 0.125; filter2(6,5) = 0.125;
filter2(2,2) = 0.08;filter2(2,6) = 0.08;filter2(6,2) = 0.08;filter2(6,6) = 0.08;

filter2 = filter2 .* 0.2;
filteredImg = ApplyFilter(img_with_noise,filter2);
figure 
colormap gray
subplot(1,3,1);
imshow(img_with_noise);
subplot(1,3,2);
imshow(1 - filter2, 'DisplayRange', [0.85 1]);
subplot(1,3,3);
imshow(filteredImg);

%%%%% filter 3 %%%%%%
filter3 = zeros(20,40);
e = size(filter3,2);
for i = 1 : size(filter3,1)
    filter3(i,i) = 0.035;
    filter3(i,e) = 0.035;
    e = e - 1;
end
filteredImg = ApplyFilter(originalRGB, filter3);

figure 
colormap gray
subplot(1,3,1);
imshow(originalRGB);
subplot(1,3,2);
imshow(1 - filter3,'DisplayRange', [0.95 1]);
subplot(1,3,3);
imshow(filteredImg);

%%%%% filter 4 %%%%%%

newImg = originalRGB;

k = 2;
for i = 265 : -1 : 1
     newImg(:,i,:) = newImg(:,i,:) * k;
     k = k - 0.006;
end

k = 2;
for i = 266 : 531
     newImg(:,i,:) = newImg(:,i,:) * k;
     k = k - 0.006;
end

filter4 = zeros(1,41);
filter4(1,21) = 1.0;
filter4(1,20) = -0.2;
filter4(1,22) = -0.2;
filteredImg = ApplyFilter(newImg, filter4);
figure 
subplot(1,3,1);
imshow(newImg);
subplot(1,3,2);
plot(filter5);
subplot(1,3,3);
imshow(filteredImg);

%% Lecture 3 - Slide 49

sampling_factor = 8;
window = 128;
[x, fs] = audioread('49.mp3');

[S, T, F] = myspectrogram(x, fs, window);
figure('name','Actual Signal Spectogram','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

y = 1 : sampling_factor : length(x);

sampled = zeros(1,length(y));

for i = 1 : length(y)
    sampled(i) = x(y(i));
end

[S, T, F] = myspectrogram(sampled.', fs/sampling_factor, window);
figure('name','Signal sampled at 1/8 (Aliasing)','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

low_pass_filter = fir1(50, 1/sampling_factor);
filteredSignal = conv(x, low_pass_filter);

y = 1 : sampling_factor : length(filteredSignal);
sampled = zeros(1,length(y));

for i = 1 : length(y)
    sampled(i) = filteredSignal(y(i));
end

[S, T, F] = myspectrogram(sampled.', fs/sampling_factor, window);
figure('name','Sampled Signal after Lowpass filter ','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

%% Lecture 4 - Slide 50

input = zeros(100,100);

filter = zeros(3);
filter(:) = -1/8;
filter(2,2) = 1;

for i = 30 : 70
    for j = 30 : 70
        input(i,j) = 1;
    end
end


final = conv2(input,filter);

figure('name','Lecture 4 Slide 50','numbertitle','off')
subplot(2,2,1);
imshow(input);
subplot(2,2,2);
imshow(final);

input = ones(100,100);

filter = zeros(3);
filter(:) = -1/8;
filter(2,2) = 1;

for i = 30 : 70
    for j = 30 : 70
        input(i,j) = 0;
    end
end


final = conv2(input,filter, 'valid');
subplot(2,2,3);
imshow(input);
subplot(2,2,4);
imshow(final);

%% Lecture 4 - Slide 53

img = imread('52.png');

filter = zeros(60);
factor = 100;

k = 1;
for j = 30 : -1 : 5
    filter(j,30) = k / factor;
    if j > 9
        filter(j, 31) = 0.9 * k / factor;
        filter(j, 29) = 0.9 * k / factor;
    end
    k = k - 0.025;
end

filter((31:60), :) = filter((30:-1:1), :); 
figure
colormap gray
imagesc(filter);

figure
colormap gray
imagesc(conv2(double(img),filter));

filter2 = rot90(filter);

figure
colormap gray
imagesc(filter2)

figure
colormap gray
imagesc(conv2(double(img),filter2));

filter3 = zeros(60);
factor = 100;

k = 1;
for j = 30 : -1 : 5
    filter3(j,j) = k / factor;
    if j > 9
        filter3(j, j+1) = 0.9 * k / factor;
        filter3(j, j-1) = 0.9 * k / factor; 
    end
    k = k - 0.025;
end

k = 1;
for j = 31 : 55
    filter3(j,j) = k / factor;
    
    if j < 51
        filter3(j, j+1) = 0.9 * k / factor;
        filter3(j, j-1) = 0.9 * k / factor; 
    end
    k = k - 0.025;
end

figure
colormap gray
imagesc(filter3)

figure
colormap gray
imagesc(conv2(double(img),filter3));

filter4 = rot90(filter3);
figure
colormap gray
imagesc(filter4)

figure
colormap gray
imagesc(conv2(double(img),filter4));
end

