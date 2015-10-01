function lec6_45()

data = zeros(100,200);
data(10 : 20, 20 : 40) = 1; 
data(10 : 20, 80 : 120) = 1;
data(10 : 20, 150 : 180) = 1;

data(75 : 95, 1 : 25) = 1;
data(75 : 95, 50 : 90) = 1;
data(75 : 95, 130 : 160) = 1;
data(75 : 95, 185 : 200) = 1;

figure
imagesc(imcomplement(data)),colormap gray

X = data;
M = size(data, 1);
N = size(data, 2);
R = 2;
%normRows = @(X) bsxfun(@times,X,1 ./ sqrt(sum(X.^2,2)));
%W = normRows(rand(M,R));
%H = normRows(rand(R,N));

W = rand(M,R) + 10;
H = rand(R,N);
Wlast = W;
Hlast = H;
rmsWH = 1;

iter = 0;
error = 1e-04;
%for l = 1 : 31
while rmsWH > error
iter = iter + 1;
WH = W * H;
for i = 1 : M
    for j = 1 : R
        sum1 = 0;
        for k = 1 : N
            v1 = X(i,k);
            v2 = WH(i,k) + 1;
            v3 = H(j,k);
            sum1 = sum1 + ((v1 / v2) * v3);         
        end
        W(i,j) = W(i,j) * sum1;
    end
end

for j = 1 : R
    for k = 1 : N
        sum1 = 0;
        for i = 1 : M
            v1 = X(i,k);
            v2 = WH(i,k) + 1;
            v3 = W(i,j);
            sum1 = sum1 + ((v1 / v2) * v3); 
        end
        H(j,k) = H(j,k) * sum1;
    end
end
%rmsW = convergence(W,Wlast);
%rmsH = convergence(H,Hlast);
rmsWH = convergence(W * H,Wlast * Hlast);

iter, rmsWH
Wlast = W;
Hlast = H;
end

figure
subplot(2,1,1);
plot(H(1,:));
subplot(2,1,2);
plot(H(2,:),'r');

figure
subplot(2,1,1);
plot(W(:,1));
subplot(2,1,2);
plot(W(:,2),'r');

end

