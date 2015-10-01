function swiss_new()

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
dist = zeros(N,N);
sigma = 100;

for i = 1 :  N
    for j = 1 : N
        valX = abs(data(i,1) - data(j,1)).^2;
        valY = abs(data(i,2) - data(j,2)).^2;
        valZ = abs(data(i,3) - data(j,3)).^2;
        dist(i,j) = (valX + valY + valZ).^(1/2);
    end
end

Wt  = exp((-dist.^2)/sigma); 
[sorted,sortedIx] = sort(dist,'ascend');
dist = sorted(1:neighbors+1,:);
nidx = sortedIx(1:neighbors+1,:);

W = zeros(N,N);
for col = 1:N
    temp = 1;
    for row = nidx(:,col)
        W(row,col) = Wt(temp,col);
        temp = temp +1;
    end
end
W = max(W,W'); 

end

