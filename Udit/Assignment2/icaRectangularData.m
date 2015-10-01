function icaRectangularData()

a = -1;
b = 1;
N = 1000;
r1 = (b-a).*rand(N,1) + a;
r2 = (b-a).*rand(N,1) + a;
x = 2*r1 + r2;
y = r1 + r2;
data = [x,y];
%fdata = (data.').^3;
%fdata = (data.' * data) * data.';
%W = eye(2);
% Random initial weights
%normRows = @(X) bsxfun(@times,X,1 ./ sqrt(sum(X.^2,2)));
%W = normRows(rand(2,2));
figure
scatter(x,y);

W = eye(2,2);
I = eye(2,2);

error = 0.0001;
rms = 1;
i = 0;
%for i = 1 : 1000
while rms > error
    i = i + 1;
    Y =  W * (data.');
    fY = (Y).^3;
    tmp = fY * Y.';
    dw = ((I*N) - tmp) * W/N;
    Wlast = W;
    W = W + 0.05 * dw;
    rms = convergence(W, Wlast);
end

Z = W * data.';
figure
plot(Z(1,:), Z(2,:), 'o');
end

