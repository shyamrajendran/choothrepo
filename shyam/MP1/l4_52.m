function l4_52()
image = imread('52.png');
[H,V,P] = size(image)
% image = imresize(image,0.5);
FigHandle = figure;
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