function extraCredit()

X = load('one.mat');
data = X.one;
N = size(data,2);

images = zeros(784,N);

for i = 1 : N
    images(:,i) = reshape(data{i},784,1);
end

dist = zeros(N,N);
for i = 1 :  N
    for j = 1 : N
        A = images(:,i);
        B = images(:,j);
        dist(i,j) = dot(A,B)/(norm(A)*norm(B));
    end
end

W = dist;

knn = 50;
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

[U,S,V] = svd(LNorm);

figure
colormap(jet(N));
scatter(U(:,N-2),U(:,N-1));


end

