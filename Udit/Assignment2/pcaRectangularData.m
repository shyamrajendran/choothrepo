function pcaRectangularData()

a = -0.5;
b = 0.5;
r1 = (b-a).*rand(1000,1) + a;
r2 = (b-a).*rand(1000,1) + a;

%r1 = randn(500, 1);
%r2 = randn(500, 1);

x = 2*r1 + r2;
y = r1 + r2;
data = [x,y];
figure
plot(data(:,1), data(:,2), '.');

[U, S, V] = svd(cov(data));
Z = U * data.';
figure
plot(Z(1,:), Z(2,:), '.');

normRows = @(X) bsxfun(@times,X,1 ./ sqrt(sum(X.^2,2)));
W = normRows(rand(2,2));

I = eye(2);
fdata = Z.^3;
tmp = fdata * Z.';

for i = 1 : 500   
    dw = (I - tmp) * W;
    W = W + 0.0000002 * dw;
end

Zica = W * Z;
figure
plot(Zica(1,:), Zica(2,:), '.');

end

