function hotlips()

v = VideoReader('hotlips.mp4');
video = zeros(12288,86);
i = 1;

while hasFrame(v)
    video(:,i) = reshape(rgb2gray(readFrame(v)),12288,1);
    i = i + 1;
end

N = 86;
sigma = 100;
data = video;

%{
for i = 1 :  N
    for j = 1 : N
        sum = 0;
        for k = 1 : 12288
            val = abs(data(k,i) - data(k,j)).^2;
            sum = sum + val;
        end        
        sum = -1 * sum;
        W(i,j) = exp(sum / sigma);
    end
end
%}
dist = zeros(N,N);
for i = 1 :  N
    for j = 1 : N
        A = data(:,i);
        B = data(:,j);
        dist(i,j) = dot(A,B)/(norm(A)*norm(B));
    end
end

W = dist;

knn = 8;
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
scatter(U(:,N-1),U(:,N-2),50,cmap);
%scatter(U(:,N),U(:,N-1),20,cmap);

figure
colormap gray
imagesc(reshape(video(:,1),96,128));
end

