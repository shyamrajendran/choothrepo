FigHandle = figure('name','lecture 5 - slide 52','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);

load faces.mat;

[H,V] = size(X);
for i = 1:V
    imageTensor(:,:,i) = reshape(X(:,i),M,N);
end

xrange = [1 15];
yrange = [1 15];
%patchTensor
for i = 1:V
    x = uint8(rand(1,1)*range(xrange)+min(xrange));
    y = uint8(rand(1,1)*range(yrange)+min(yrange));
    imag = imageTensor(:,:,i);
    % taking patch of 10x10 size random
    patch = imag(x:x+9,y:y+9);
    patchTensor(:,:,i) = patch;
end

for i = 1:V
    p = patchTensor(:,:,i);
    inp(:,i) = p(:);
end

X = inp;
cov_x = cov(X.');
[U,S,V] = svd(cov_x);
for i = 1:50
    subplot(5,10,i);
    imagesc(reshape(U(:,i),10,10)),colormap(bone);axis off;
end
