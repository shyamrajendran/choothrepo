function lec3_46()

img = load('one.mat');
data = img.one;
figure
colormap gray
imagesc(data);

%{
row = size(data,1);
col = size(data,2);
gradient = zeros(row,col);
for i = 2 : row - 1
    for j = 2 : col - 1
        dy = data(i+1,j) - data(i-1,j);
        dx = data(i,j+1) - data(i,j-1);
        gradient(i,j) = sqrt((dy * dy) + (dx * dx));
    end
end
%}

gradient = imggradient(data);

input_gradient = zeros(50,50);
input_gradient(10 : 40,15:30) = gradient;
figure
colormap gray
imagesc(input_gradient);

template_gradient = fliplr(flipud(gradient));
figure
colormap gray
imagesc(template_gradient);

output = conv2(template_gradient, input_gradient);
figure
colormap gray
imagesc(output);

img_complement = ones(31,16) - data;
gradient = imggradient(img_complement);

figure
colormap gray
imagesc(img_complement);

input_gradient = zeros(50,50);
input_gradient(10 : 40,15:30) = gradient;
figure
colormap gray
imagesc(input_gradient);

template_gradient = fliplr(flipud(gradient));
figure
colormap gray
imagesc(template_gradient);

output = conv2(template_gradient, input_gradient);
figure
colormap gray
imagesc(output);
end

