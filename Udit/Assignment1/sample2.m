originalRGB = imread('46.jpg');
figure, imshow(originalRGB);

k = 2;
for i = 265 : -1 : 1
     originalRGB(:,i,:) = originalRGB(:,i,:) * k;
     k = k - 0.006;
end

k = 2;
for i = 266 : 531
     originalRGB(:,i,:) = originalRGB(:,i,:) * k;
     k = k - 0.006;
end
     
%originalRGB(:,150 : 350,:) = originalRGB(:,150 : 350,:) * 1.4;
%originalRGB(:,1 : 150,:) = originalRGB(:,1 : 150,:) * 0.6;
%originalRGB(:,350 : 531,:) = originalRGB(:,350 : 531,:) * 0.6;
figure, imshow(originalRGB);

%filter4 = [1:41];
%m = mean(filter4);
%v = var(filter4);
%filter4 = (6 / (2 * v)) * exp(-1 * abs(filter4 - m) / v);
filter4 = zeros(1,41);
filter(1:19) = -0.05;
filter(23:41) = -0.05;
filter4(1,21) = 1.0;
filter4(1,20) = -0.2;
filter4(1,22) = -0.2;

%H = fspecial('laplacian');
%k = imfilter(originalRGB,H);
%figure, imshow(k);
figure, colormap gray,plot(filter4);
filteredImg = ApplyFilter(originalRGB, filter4);
figure, imshow(filteredImg);