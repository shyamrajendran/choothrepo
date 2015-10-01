load('cities.mat');
%%
in = D;
[r,c] = size(in);
for i = 1:r
    sum = 0;
    for j = 1:c
        sum = sum + in(i,j);
    end
    avg = sum/c;
    avg
    for j = 1:c
        in(i,j) = in(i,j)-avg; 
    end
    avg = 0;
end

for j = 1:c
    sum = 0;
    for i = 1:r
        sum = sum + in(i,j);
    end
    avg = sum/r;
    for i = 1:r
        in(i,j) = in(i,j)-avg; 
    end
end


[U,S,V] = svd(cov(in));
% taking only top 3 components 
U = U(:,1:3);
Z = U.'*in;
X1 = Z(1,:);
Y1 = Z(2,:);
Z1 = Z(3,:);
%%
FigHandle = figure('name','lecture 7 - 26','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 400]);
subplot(1,2,1)
imagesc(in);colormap gray;axis xy;
subplot(1,2,2)
scatter3(Y1,Z1,X1);
text(Y1,Z1,X1,cities);