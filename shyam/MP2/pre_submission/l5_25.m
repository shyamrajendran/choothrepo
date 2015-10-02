FigHandle = figure('name','lecture 5 - 25','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);
%%
N = 1000;
x1 = randn(1,N);
a = -1;
b = 1;
r = (b-a).*rand(1,N) + a;
y1 = (x1+r) ;
y1 = y1/max(abs(y1(:)));

% plotting input
subplot(1,2,1);
scatter(x1,y1);
X = [x1;y1];

%% taking PCA 
cov_x = cov(X.');
[U,S,V] = svd(cov_x);
R = U*X;

% seperating X and Y for scatter plot purpose
x_plot = R(1,:);
y_plot = R(2,:);

% plotting the Eigen Vectors
hold on 
plot(U(:,1));
plot(U(:,2));
hold off;

% plotting the PCA output
subplot(1,2,2);
scatter(x_plot,y_plot);

