originalRGB = imread('46.jpg');
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

%filter4 = [1:41];
%m = mean(filter4);
%v = var(filter4);
%filter4 = (6 / (2 * v)) * exp(-1 * abs(filter4 - m) / v);
filter5 = zeros(1,41);
%filter5(1:19) = -0.05;
%filter5(23:41) = -0.05;
filter5(1,21) = 1.0;
filter5(1,20) = -0.1;
filter5(1,22) = -0.1;
filteredImg = ApplyFilter(newImg, filter5);
figure, imshow(newImg);
figure, imshow(filteredImg);