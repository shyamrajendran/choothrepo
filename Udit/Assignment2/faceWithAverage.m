function faceWithAverage()

load('faces.mat');

T = X;
%Compute Average Face
averageFace = zeros(780,1);
for i = 1 : 600
    averageFace = averageFace + X(:,i);
end

averageFace = averageFace / 600;

figure
colormap(bone);
imagesc(reshape(averageFace,30,26));

for i = 1 : 600
    X(:,i) = X(:,i) - averageFace;
end

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
imagesc(reshape(averageFace + X(:,11),30,26));
subplot(2,2,2);
imagesc(reshape(averageFace + recoveredFaces(:,11),30,26));

topEigenFaces = U(:, 1:10).';
projectedWeights = topEigenFaces * X;
recoveredFaces = topEigenFaces.' * projectedWeights;
subplot(2,2,3);
imagesc(reshape(averageFace + X(:,11),30,26));
subplot(2,2,4);
imagesc(reshape(averageFace + recoveredFaces(:,11),30,26));

img = reshape(T(:,11),30,26);
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

%%Compute Average Patch

averagePatch = zeros(100,1);
for i = 1 : size(patchedImg,2)
    averagePatch = averagePatch + patchedImg(:,i);
end

averagePatch = averagePatch / size(patchedImg,2);

for i = 1 : size(patchedImg,2)
    patchedImg(:,i) = patchedImg(:,i) - averagePatch;
end

%{
for i = 1 : 4 : 21
     for j = 1 : 4 : 17
         patch = img(i : i+9,j : j+9);
         patchedImg(:,count) = reshape(patch,100,1);
         count = count + 1;
     end
end
%}
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

