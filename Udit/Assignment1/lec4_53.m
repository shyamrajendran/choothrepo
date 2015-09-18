function lec4_53()

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

