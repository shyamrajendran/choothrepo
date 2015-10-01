v = VideoReader('hotlips.mp4');
data = [];
while v.hasFrame()
    frame = v.readFrame();
    frame = rgb2gray(frame);
    frame = frame(:);
    data = [data frame];
end
data = double(data);
figure;
imagesc(data);
colormap(gray);

m = size(data,2);
N=size(data,2);

neighbors  = 8; 
sigma = 100; 

% calculate pairwise distances
dist = zeros(m,m);
for row = 1:m
    for col = 1:m
        A = data(:,row);
        B = data(:,col);
        dist(row,col) = dot(A,B)/(norm(A)*norm(B));
    end
end

[sorted,sortedIx] = sort(dist,'ascend');
dist = sorted(1:neighbors+1,:);
nidx = sortedIx(1:neighbors+1,:);

Wt  = dist;


W = zeros(N,N);
for col = 1:N
    temp = 1;
    for row = nidx(:,col)
        W(row,col) = Wt(temp,col);
        temp = temp +1;
    end
end
W = max(W,W'); 

D = diag((ones(N,1)') * W);
sqD = (D^(-1/2));
L = W - D;
Lnorm = sqD*L*sqD;
Lnorm = max(Lnorm,Lnorm');

[v,d] = eigs(Lnorm,3,'sm');

figure;
scatter(v(:,2),v(:,3),100,'filled')
title('Laplacian Eigenmap')

