function patchesPca()

load('faces.mat');

patchedImg = zeros(100,600);

for i = 1 : 600
    img = reshape(X(:,i),30,26);
    col = randi([1 21],1);
    row = randi([1 17],1);
    patch = img(col : col+9,row : row+9);
    patchedImg(:,i) = reshape(patch,100,1);
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

