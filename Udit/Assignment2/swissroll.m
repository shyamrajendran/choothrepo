function swissroll()

N = 1200;
t = rand(1,N);
t = sort(4*pi*sqrt(t))'; 
z = 8*pi*rand(N,1); % random heights
x = t.*cos(t);
y = t.*sin(t);
data = [x,y,z];
size(data)

W = zeros(N,N);
sigma = 100;

for i = 1 :  N
    for j = 1 : N
        valX = abs(data(i,1) - data(j,1)).^2;
        valY = abs(data(i,2) - data(j,2)).^2;
        valZ = abs(data(i,3) - data(j,3)).^2;
        sum = -1 * (valX + valY + valZ);
        W(i,j) = exp(sum / sigma);
    end
end

knn = 25;
for i = 1 : N
    [sortedData,sortedIndex] = sort(W(i,:),'descend');
    W(i,i) = 0;
    for j = knn+2 : N
        W(i,sortedIndex(j)) = 0;
    end
end

row_ones = ones(1,N);
sum = row_ones * W;
D = diag(sum);

for i = 1 : N
    if sum(i) ~= 0
        sum(i) = sum(i).^(-1/2);
    end
end
D1 = diag(sum);
L = W - D;
LNorm = (D1) * L * (D1);
figure
imagesc(LNorm);
%dt               = srtdDt(2:knn+1,:);
%nidx             = srtdIdx(2:knn+1,:);

[U,S,V] = svd(LNorm);
%U = U(:, N-2 : N-1).';

%Z = U * LNorm;
cmap = jet(N);
figure
colormap(jet(N));
scatter(U(:,N-1),U(:,N-2),20,cmap);
figure
scatter3(x,y,z,20,cmap);
title('Original data');

end

