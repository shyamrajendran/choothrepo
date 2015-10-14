%%
%%%%%%%%lecture 8 slide 30
clearvars 
shot = 'shot.wav';
[h, fs] = audioread(shot);
figure, plot(h)

pa = 'pa.wav';
[pa, fspa] = audioread(pa);
figure, plot(pa);

num_samples_op = length(h) + length(pa) -1;
zero_pad_h = [h.' zeros(1,num_samples_op - length(h))];
figure, plot(zero_pad_h)

zero_pad_pa = [pa.' zeros(1,num_samples_op - length(pa))];
op = ifft(fft(zero_pad_h) .* fft(zero_pad_pa));
abs_op = abs(op);
num_avg = 1000;
coef = ones(1,num_avg)/ num_avg;
op1 = filter(coef, 1, abs_op);
figure, plot(pa, 'b');
hold on
plot(op1./10, 'r')
title('fft based matched filter')
% FigHandle = figure('name','lecture 8 slide 30','numbertitle','off');
%%%%%%%%%%% time domain matched filter
h_flipped = flipud(h);
op = conv(pa,h_flipped);
abs_op = abs(op);
figure, plot(abs_op), title('matched filter abs op')
%%%%%%%%%%smooth the matched filter op and overlay on top orginal signal
%%%%%%%%average out num_avg samples
num_avg = 1000;
coef = ones(1,num_avg)/ num_avg;
op1 = filter(coef, 1, abs_op);
figure, plot(pa, 'b');
hold on
plot(op1./10, 'r')
title('time domain matched filter')

%%%%%%%%% %%%%time domain convolution
% 
% zero_pad_pa = [zeros(1, length(h)) pa.' zeros(1, length(h))];
% op_matched_filter = zeros(1, length(zero_pad_pa));
% h_flipped = flipud(h);
% figure, plot(h_flipped)
% for i = 1 : length(zero_pad_pa) - length(h_flipped)
%     sum = 0;
%     for k = 1 : length(h_flipped)
%         sum = sum + h_flipped(k) * zero_pad_pa(i + k - 1);
%     end
%     op_matched_filter(i) = sum;
% end


%%
%%%%%%%%%%%%lecture 8 slide 46
clearvars
load('one.mat')
figure,
colormap gray
imagesc(one)
[row, col] = size(one);

one_gradient = zeros(row,col);
for i = 2: (row - 1)
    for j = 2 : (col - 1)
        dy = one(i-1, j) - one(i+1, j);
        dx = one(i, j-1) - one(i, j+1);
        one_gradient(i,j) = sqrt(dy.^2 + dx.^2);
    end
end

figure,
colormap gray
imagesc(one_gradient)


template_flipped = fliplr(flipud(one_gradient));
figure, colormap gray
imagesc(template_flipped)

input_gradient = [zeros(20,30);zeros(31,7) one_gradient zeros(31,7);zeros(20,30)];
figure, colormap gray,imagesc(input_gradient)

convop = conv2(input_gradient, template_flipped);
figure, colormap gray
imagesc(convop)


%%%%%%%% now on compliment image
compliment_image = ones(row,col) - one;
figure,
colormap gray
imagesc(compliment_image)

one_comp_gradient = zeros(row,col);
for i = 2: (row - 1)
    for j = 2 : (col - 1)
        dy = compliment_image(i-1, j) - compliment_image(i+1, j);
        dx = compliment_image(i, j-1) - compliment_image(i, j+1);
        one_comp_gradient(i,j) = sqrt(dy.^2 + dx.^2);
    end
end

figure,
colormap gray
imagesc(one_comp_gradient)

template_flipped = fliplr(flipud(one_comp_gradient));
figure, colormap gray
imagesc(template_flipped)

input_gradient = [zeros(20,30);zeros(31,7) one_comp_gradient zeros(31,7);zeros(20,30)];
figure, colormap gray,imagesc(input_gradient)

convop = conv2(input_gradient, template_flipped);
figure, colormap gray
imagesc(convop)


