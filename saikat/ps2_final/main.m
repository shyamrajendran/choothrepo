%%
clearvars
N = 500;
theta = 150;
y1 = 5 * randn(N,1);
y2 = 1 * randn(N,1);
rotation = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
Y = [y1, y2] * rotation;
y1 = Y(:,1);
y2 = Y(:,2);
%%%%make zero mean
mean_y1 = mean(y1);
mean_y2 = mean(y2);
y1 = y1 - mean_y1;
y2 = y2 - mean_y2;
figure('Name','lecture 5.25','numbertitle','off');
scatter(y1,y2, '.');
title('input data')
X = [y1 y2];
cov_X = cov(X);
[U, S, V] = svd(cov_X);
max_eigen_vec = U(:,1);
max_eigen_val = S(1,1);
min_eigen_vec = U(:,2);
min_eigen_val = S(2,2);

%%%%%%%%%input is 0 mean%%%%%%
X0 = 0;
Y0 = 0;
figure('Name','lecture 5.25','numbertitle','off');
subplot(1,2,1);
plot(X(:,1), X(:,2), '.'), title('input data');
hold on
quiver(X0, Y0, max_eigen_vec(1)*sqrt(max_eigen_val), max_eigen_vec(2)*sqrt(max_eigen_val), 'r');
quiver(X0, Y0, min_eigen_vec(1)*sqrt(min_eigen_val), min_eigen_vec(2)*sqrt(min_eigen_val), 'g');

Z = U.' * X.';
subplot(1,2,2);
plot(Z(1,:), Z(2,:), '.'), title('feature weights');
%%
%%%%%%%%%%%%% Lecture 5 Slide 37 %%%%%%%%%%%%%%%%
clearvars
load('faces.mat');
figure('Name','input faces','numbertitle','off');
colormap bone
for i = 1:36
    subplot(6,6,i);
    imagesc(reshape(X(:,i),M,N))
end
total_face = sum(X, 2);
mean_face = total_face ./ N;
figure
colormap bone
imagesc(reshape(mean_face, M,N))
title('mean face')

X_zero_mean = X;
for i = 1:N
    X_zero_mean(:,i) = X_zero_mean(:,i) - mean_face;
end
cov_X = cov(X_zero_mean.');
[U,S,V] = svd(cov_X);
h = figure('Name','Eigen Faces','numbertitle','off');
for i = 1:36
    subplot(6,6,i);
    imagesc(reshape(U(:,i),M,N)),colormap(bone);
end

%%%%%%%%%%%%%%% lecture 5 slide 39
reduced_dim = [50 10];
for i = 1:length(reduced_dim)
    cur_dim = reduced_dim(i);
    W = U.';
    W = W(1:cur_dim,:);
    Z = W * X_zero_mean;
    approx_x = W.' * Z;
    figure('name','lecture 5.39','numbertitle','off');
    subplot(1,2,1)
    imagesc(reshape(X(:,11),M,N)),colormap(bone),title('input face');
    subplot(1,2,2)
    imagesc(reshape(approx_x(:,11) + mean_face,M,N)),colormap(bone),title(['approx for k=',int2str(reduced_dim(i))]);
end
%%
%%%%%%%%%%%% lecture 5 slide 51-52
clearvars
load('faces.mat');
[row, col] = size(X);
patch_size = 10;
patches_input = zeros(patch_size * patch_size, col);
for i = 1:col
    cur_image = X(:,i);
    cur_image = reshape(cur_image, M, N);
    r = randi([1 (M-patch_size)]);
    start_row = r;
    end_row = r + patch_size - 1;
    c = randi([1 (N-patch_size)]);
    start_col = c;
    end_col = c + patch_size - 1;
    image = cur_image(start_row : end_row, start_col : end_col);
    patches_input(:,i) = image(:);
end

figure('name','lecture 5.51-52','numbertitle','off');
colormap gray
imagesc(patches_input)
title('input pacthes')

mean_patch = sum(patches_input,2) ./ col;
for i = 1 : col
    patches_input(:,i) = patches_input(:,i) - mean_patch;
end

cov_X = cov(patches_input.');
[U,S,V] = svd(cov_X);

figure('name','lecture 5.51-52','numbertitle','off');
for i = 1:50
    subplot(5,10,i);
    imagesc(reshape(U(:,i), patch_size, patch_size)), colormap(bone);
end
%%
%%%%%%%%%% lecture 6 slide 22%%%%%%%%%%%%%%%%%%%%%%
clearvars
low = -1;
high = 1;
num_points = 1000;
r1 = (high-low).*rand(num_points,1) + low;
r2 = (high-low).*rand(num_points,1) + low;
x = 2 * r1 + r2;
y = r1 + r2;

figure('name','lecture 6.22','numbertitle','off');
scatter(x,y);
title('Input')

X = [x.';y.'];
cov_X = cov(X.');
[U, S, V] = svd(cov_X);

new_X = U * X;
figure('name','lecture 6.22','numbertitle','off');
scatter(new_X(1,:), new_X(2,:))
title('PCA op')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W = eye(2);
I = eye(2);

alpha = 0.05;
count = 0;
max_iter = 500;
error = 100;
while (count < max_iter) && (error > 0.0001)
    W_last = W;
    Y = W * X;
    Y_3 = Y.^3;
    delta = minus(I*num_points, Y_3 * Y') * W/num_points;
    delta = delta .* alpha;
    W = W + delta;
    error = myrms(W_last, W);
    count = count + 1;
end
count
Y_ICA_new = W * X;
figure('name','lecture 6.22','numbertitle','off');
scatter(Y_ICA_new (1,:), Y_ICA_new (2,:))
title('ICA op')
%%
%%%%%%%%%% lecture 6 slide 32%%%%%%%%%%%%%%%%%%%%%%
clearvars
load('faces.mat');
samples = 600
total_face = sum(X, 2);
mean_face = total_face ./ samples;
for i = 1:N
    X(:,i) = X(:,i) - mean_face;
end
%%%%%%%%%%%%%%%%%%%%PCA%%%%%%%%%%%%%%%
cov_X = cov(X.');
[U,S,V] = svd(cov_X);
cur_dim = 16;
W_PCA = U.';
W_PCA = W_PCA(1:cur_dim,:);
Z_PCA = W_PCA * X;
PCA_op = W_PCA.' * Z_PCA;
figure('name','lecture 6.32 Eigen Faces','numbertitle','off');
colormap bone
for i = 1:16
    subplot(4,4,i);
    imagesc(reshape(W_PCA(i,:),M,N))
end
%%%%%%%%%%%%%%%%%%%%ICA %%%%%%%%%%%%%%
W_ICA = eye(16,16);%rand(16,16);
I = eye(16);
alpha = 1e-16;
count = 0;
max_iter = 500;
error = 100;
X = Z_PCA;
target_error = 1e-5;
while (count < 5000) && (error > target_error)
    W_last = W_ICA;
    Y = W_ICA * X;
    Y_3 = Y.^3;
    delta = minus(I*samples, Y_3 * Y') * W_ICA / samples;
    delta = delta * alpha;
    W_ICA = W_ICA + delta;
    error = myrms(W_last, W_ICA);
    count = count + 1;
end
count
new_W = W_ICA * W_PCA;

figure('name','lecture 6.32 ICA faces','numbertitle','off');
colormap bone
for i = 1:16
    subplot(4,4,i);
    imagesc(reshape(new_W(i,:),M,N))
end
%%
%%%%%%%%%% lecture 6 slide 45%%%%%%%%%%%%%%%%%%%%%%
clearvars
input = [zeros(10,200);
         zeros(10,22) ones(10, 18) zeros(10,40) ones(10,40) zeros(10,30) ones(10,30) zeros(10,20);
         zeros(55,200);
         ones(15,25) zeros(15,25) ones(15, 40) zeros(15,40) ones(15, 30) zeros(15, 25) ones(15,15);
         zeros(10,200)];
figure
colormap gray
imagesc(imcomplement(input))
title('input data')
%%%%%%%%%%%%%%input, dim, max_iter, factor, error
[w, h] = mynmf(input, 2, 100, 3e-05);
figure('name','lecture 6.45','numbertitle','off');
subplot(2,1,1)
plot(w(:,1)), title('Col W(1)');
subplot(2,1,2)
plot(w(:,2)),title('Col W(2)');
figure('name','lecture 6.45','numbertitle','off');
subplot(2,1,1)
plot(h(1,:)), title('Row H(1)');
subplot(2,1,2)
plot(h(2,:)), title('Row H(2)');
%%
%%%%%%%%%% lecture 6 slide 51,52,54%%%%%%%%%%%%%%%%%%%%%%
clearvars
input_video = VideoReader('hands.mp4');
i = 1;
while hasFrame(input_video)
    f = readFrame(input_video);
    f_gray = rgb2gray(f);
    input(:, i) = f_gray(:);
    i = i + 1;
end
input_double = double(input);
[V, D] = eigs(cov(input_double.'));
V1 = V(:,1:3);
W_PCA = V1.';
Z_PCA = W_PCA * input_double;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('name','lecture 6.51','numbertitle','off');
subplot(1,3,1)
colormap bone
imagesc(reshape(W_PCA(1,:), 60,80) .* 300), title('principal component1');
subplot(1,3,2)
colormap bone
imagesc(reshape(W_PCA(2,:), 60,80) .* 300), title('principal component2');
subplot(1,3,3)
colormap bone
imagesc(reshape(W_PCA(3,:), 60,80) .* 300), title('principal component3');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('name','lecture 6.51','numbertitle','off');
plot(Z_PCA(1,:))
hold on
plot(Z_PCA(2,:))
hold on
plot(Z_PCA(3,:))
title('PCA component weights')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ICA
W_ICA = eye(3,3)%rand(3,3);
I = eye(3);
alpha = 1e-16;
count = 0;
max_iter = 500;
error = 100;

X = Z_PCA;
samples = 123;
target_error = 1e-6;
while (count < 5000) && (error > target_error)
    W_last = W_ICA;
    Y = W_ICA * X;
    Y_3 = Y.^3;
    delta = minus(I*samples, Y_3 * Y') * W_ICA / samples;
    delta = delta * alpha;
    W_ICA = W_ICA + delta;
    error = myrms(W_last, W_ICA);
    count = count + 1;
end
count
new_W = W_ICA * W_PCA;
Z_NEW = new_W * input_double;

figure('name','lecture 6.52','numbertitle','off');
subplot(1,3,1)
colormap bone
imagesc(reshape(new_W(1,:), 60,80) .* 300), title('independent component1');
subplot(1,3,2)
colormap bone
imagesc(reshape(new_W(2,:), 60,80) .* 300), title('independent component2');
subplot(1,3,3)
colormap bone
imagesc(reshape(new_W(3,:), 60,80) .* 300), title('independent component3');

figure('name','lecture 6.52','numbertitle','off');
plot(Z_NEW(1,:))
hold on
plot(Z_NEW(2,:))
hold on
plot(Z_NEW(3,:))
title('ICA Component weights')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%input, dim, max_iter, error
[w,h] = mynmf(input_double, 3, 100,1e-05);

figure('name','lecture 6.53-54','numbertitle','off');
subplot(1,3,1)
colormap gray
imagesc(reshape(w(:,1), 60,80)), title('non negative component 1');
subplot(1,3,2)
colormap gray
imagesc(reshape(w(:,2), 60,80)), title('non negative component 2');
subplot(1,3,3)
colormap gray
imagesc(reshape(w(:,3), 60,80)), title('non negative component 3');

figure('name','lecture 6.53-54','numbertitle','off');
subplot(3,1,1)
plot(h(1,:), 'g'), title('component weight 1');
subplot(3,1,2)
plot(h(2,:), 'b'), title('component weight 2');
subplot(3,1,3)
plot(h(3,:), 'r'), title('component weight 3');
%%
%%%%%%%%%% lecture 7 slide 36%%%%%%%%%%%%%%%%%%%%%%
clearvars
load('cities.mat');
input = D;
[row, col] = size(input);

figure('name','lecture 7.36','numbertitle','off');
colormap bone
imagesc(input)
title('city distances')
row_mean = sum(input, 2) ./ col;
input_row_mean = zeros(row, col);
for i = 1 : col
    input_row_mean(:,i) = input(:,i) - row_mean;
end

col_mean = sum(input_row_mean) ./ row;
op = zeros(row, col);
for i = 1 : row
    op(i,:) = input_row_mean(i,:) - col_mean;
end

cov_op = cov(op);
[U, S, V] = svd(cov_op);
Z1 = U(:,1:3).' * op;
figure('name','lecture 7.36','numbertitle','off');
scatter3(Z1(1,:),Z1(2,:),Z1(3,:));
text(Z1(1,:),Z1(2,:),Z1(3,:),cities);

Z2 = U(:,1:2).' * op;
figure
scatter(Z2(1,:),Z2(2,:))
title('2d plot')
text(Z1(1,:),Z1(2,:),cities);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% lecture 7 slide 56
clearvars
N = 1024;
%%%%%%%%%%%% generate swiss roll data
t = sort(4 * pi * sqrt(rand(N,1))); 
x = (t+ 0.5).*cos(t);
y = (t+ 0.5).*sin(t);
z = 8 * pi * rand(N,1);
figure('name','lecture 7.56','numbertitle','off');
cmap = jet(N);
scatter3(x,y,z,20,cmap);
title('Input data');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% neighbours = 35;
W = zeros(N, N);
sigma = 100;
for i = 1 : N
    for j = 1: N
        x_d = (x(i) - x(j)) .^ 2;
        y_d = (y(i) - y(j)) .^ 2;
        z_d = (z(i) - z(j)) .^ 2;
        d = x_d + y_d + z_d;
        W(i,j) = exp(-1 * d / sigma);
    end
end
neighbours = [8 25 35 40];
new_W = zeros(N,N);
figure('name','lecture 7.56','numbertitle','off');
for count = 1:length(neighbours)
for i = 1:N
    [D, I] = sort(W(i,:));
    for j = N-1 : -1: N - neighbours(count) + 1
        max_index = I(j);
        new_W(i,max_index) = D(j);
    end
end

sum_rows_W = ones(1,N) * new_W;
L = new_W - diag(sum_rows_W);
for i = 1 : N
    %%%%% to avoid divide by 0, if check
    if (sum_rows_W(i) ~= 0)
        sum_rows_W(i) = sum_rows_W(i).^(-1/2);
    end
end
D1 = diag(sum_rows_W);
L_Norm = (D1*L*D1);
[U,S,V] = svd(L_Norm);
% figure('name','lecture 7.56','numbertitle','off');
% scatter(U(:,N-1),U(:,N-2),20,cmap)
subplot(1,length(neighbours), count)
scatter(U(:,N-1),U(:,N-2),20,cmap),title(['K =', int2str(neighbours(count))]);
end
%%
%%%%%%%%%% lecture 7 slide 68
clearvars
input_video = VideoReader('hotlips.mp4');
i = 1;
while hasFrame(input_video)
    f = readFrame(input_video);
    f_gray = rgb2gray(f);
    input(:, i) = f_gray(:);
    i = i + 1;
end
input_double = double(input);
W = zeros(86, 86);
sigma = 100;
N = 86;
for i = 1 : N
    x = input_double(:,i);
    for j = 1: N
        y = input_double(:,j);
        W(i,j) = dot(x,y)/(norm(x)*norm(y));
    end
end
neighbours = [4 8 25];
figure('name','lecture 7.68','numbertitle','off');
for count = 1:length(neighbours)
    new_W = zeros(N,N);
    for i = 1:N
        [sort_data, sort_index] = sort(W(i,:));
        for j = N-1 : -1: N - neighbours(count) + 1
            max_index = sort_index(j);
            new_W(i,max_index) = sort_data(j);
        end
    end

    sum_rows_W = ones(1,N) * new_W;
    L = new_W - diag(sum_rows_W);
    for i = 1 : N
        if (sum_rows_W(i) ~= 0)
            sum_rows_W(i) = sum_rows_W(i).^(-1/2);
        end
    end
    D1 = diag(sum_rows_W);
    L_Norm = (D1*L*D1);
    [U,S,V] = svd(L_Norm);
    subplot(1,length(neighbours), count)
    scatter(U(:,N-1),U(:,N-2),'r'), title(['K =', int2str(neighbours(count))]);
end
%%
%%%%%%%%%%%%%%%% extra question
clearvars
load('one.mat')
[row, col] = size(one);
neighbours = 100
len = 28 * 28;
input = zeros(len, col);
for i  = 1:col
    input(:, i) = one{i}(:);
end

N = 1135;
W = zeros(N, N);
sigma = 100;
for i = 1 : N
    x = input(:,i);
    for j = 1: N
        y = input(:,j);
        W(i,j) = dot(x,y)/(norm(x)*norm(y));
    end
end

new_W = zeros(N,N);
for i = 1:N
    [sort_data, sort_index] = sort(W(i,:));
    for j = N-1 : -1: N - neighbours + 1
        max_index = sort_index(j);
        new_W(i,max_index) = sort_data(j);
    end
end

sum_rows_W = ones(1,N) * new_W;
L = new_W - diag(sum_rows_W);
for i = 1 : N
    if (sum_rows_W(i) ~= 0)
        sum_rows_W(i) = sum_rows_W(i).^(-1/2);
    end
end
D1 = diag(sum_rows_W);
L_Norm = (D1*L*D1);
[U,S,V] = svd(L_Norm);
figure('name','extra question','numbertitle','off');
scatter(U(:,N-1),U(:,N-2))
title('LE')

