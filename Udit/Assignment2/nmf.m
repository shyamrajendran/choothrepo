function nmf(X, R)

M = size(X, 1);
N = size(X, 2);

%normRows = @(X) bsxfun(@times,X,1 ./ sqrt(sum(X.^2,2)));
%W = normRows(rand(M,R));
%H = normRows(rand(R,N));

W = rand(M,R);
H = rand(R,N);
Wlast = W;
Hlast = H;
val = 1;

iter = 0;
%for l = 1 : 6
error = 5e-04;
while val > error
iter = iter + 1;
WH = W * H;
for i = 1 : M
    for j = 1 : R
        sum1 = 0;
        for k = 1 : N
            v1 = X(i,k);
            v2 = WH(i,k);
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
            v2 = WH(i,k);
            v3 = W(i,j);
            sum1 = sum1 + ((v1 / v2) * v3); 
        end
        H(j,k) = H(j,k) * sum1;
    end
end
%val = convergence(W,Wlast);
val = convergence(W * H,Wlast * Hlast);

iter, val
Wlast = W;
Hlast = H;
end

figure
plot(H(1,:));
hold on
plot(H(2,:),'r');
hold on
plot(H(3,:),'g');

figure
subplot(3,1,1);
plot(H(1,:));
subplot(3,1,2);
plot(H(2,:),'r');
subplot(3,1,3);
plot(H(3,:),'g');

%figure
%subplot(1,3,1);
%imagesc(reshape(W(:,1) .* 0.001,60,80,3));
%subplot(1,3,2);
%imagesc(reshape(W(:,2) .* 0.001,60,80,3));
%subplot(1,3,3);
%imagesc(reshape(W(:,3) .* 0.00002,60,80,3));

end

