function faces()

load('faces.mat');

[U,S,V] = svd(cov(X.'));
%[U,S,V] = svd(X);
figure
colormap(bone);
for i = 1 : 36
    cur_img = U(:, i);
    subplot(6,6,i);
    imagesc(reshape(cur_img,30,26));
    axis off
end

topEigenFaces = U(:, 1:50).';
projectedWeights = topEigenFaces * X;
recoveredFaces = topEigenFaces.' * projectedWeights;
figure
colormap(bone);
subplot(2,2,1);
imagesc(reshape(X(:,11),30,26));
subplot(2,2,2);
imagesc(reshape(recoveredFaces(:,11),30,26));

topEigenFaces = U(:, 1:10).';
projectedWeights = topEigenFaces * X;
recoveredFaces = topEigenFaces.' * projectedWeights;
subplot(2,2,3);
imagesc(reshape(X(:,11),30,26));
subplot(2,2,4);
imagesc(reshape(recoveredFaces(:,11),30,26));

load('faces.mat');
img = reshape(X(:,11),30,26);
%patchedImg = zeros(100,30);
patchedImg = zeros(100,357);
count = 1;

for i = 1 : 21
    for j = 1 : 17
        patch = img(i : i+9,j : j+9);
        patchedImg(:,count) = reshape(patch,100,1);
        count = count + 1;
    end
end    
%for i = 1 : 4 : 21
%     for j = 1 : 4 : 17
%         patch = img(i : i+9,j : j+9);
%         patchedImg(:,count) = reshape(patch,100,1);
%         count = count + 1;
%     end
%end

[U,S,V] = svd(cov(patchedImg.'));
figure
colormap(bone);
for i = 1 : 40
    cur_img = U(:, i);
    subplot(5,8,i);
    imagesc(reshape(cur_img,10,10));
    axis off
end

end


