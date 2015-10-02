FigHandle = figure('name','lecture 6 - 22','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1300, 300]);

N = 300;
%range -1 to 1
a = -1;
b = 1;
r1 = (b-a).*rand(N,1) + a;
r2 = (b-a).*rand(N,1) + a;

x = 2*r1 + r2;
y = r1 + r2;

X = zeros(2,N);
X(1,:) = x;
X(2,:) = y;

subplot(1,3,1)
scatter(x,y);title('input');

% PCA
cov_x = cov(X.');
[U,S,V] = svd(cov_x);
R = U*X;
x_plot = R(1,:);
y_plot = R(2,:);

subplot(1,3,2)
scatter(x_plot,y_plot);title('PCA');

W = eye(2);
D = eye(2);
learningRate = 0.005;
delta = 0.00001;

% ICA
W = helperICA(learningRate, delta, W, X, D, N);
op = W*X;
size(op)
subplot(1,3,3)
scatter(op(1,:),op(2,:)),title('ICA');
