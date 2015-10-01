% generate data
clear;
N = 1500; % number of points to put in swiss roll
t = rand(1,N)';
t = sort(9*sqrt(t));

z = 25*rand(N,1); % assign random heights
x = (t).*sin(t);
y = (t).*cos(t);
data = [x,y,z]; 
m = size(data,1);
figure,subplot(1,2,1)
colorsmap = jet(N);
scatter3(x,y,z,25,colorsmap,'filled');
title('Original data');


neighbors  = 25; 
sigma = 100; 

% calculate pairwise distances
dist = squareform(pdist(data));
[sorted,sortedIx] = sort(dist,'ascend');
dist = sorted(1:neighbors+1,:);
nidx = sortedIx(1:neighbors+1,:);

Wt  = exp((-dist.^2)/sigma); 

% recreate weight matrix
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



subplot(1,2,2)
scatter(v(:,2),v(:,3),25,colorsmap,'filled')
title('Laplacian Eigenmap')

