function main()

%% Lecture 3 Slide 25
x = 4 * randn(500,1);
y = 1 * randn(500,1);
Cov = [cosd(135) -sind(135); sind(135) cosd(135)];
data = [x, y] * Cov;

[U, S, V] = svd(cov(data));

figure
subplot(1,2,1);
plot(data(:,1), data(:,2), 'o');
hold on
plot(U(:,1),'g');
hold on
plot(U(:,2),'r');

Z = U * data.';
subplot(1,2,2);
plot(Z(1,:), Z(2,:), 'o');

%% Lecture 3 Slide 37 & 39

faces_data = load('faces.mat');
X = faces_data.X;

%Compute Average Face
averageFace = zeros(780,1);
for i = 1 : 600
    averageFace = averageFace + X(:,i);
end

averageFace = averageFace / 600;

for i = 1 : 600
    X(:,i) = X(:,i) - averageFace;
end

[U,S,V] = svd(cov(X.'));

figure
colormap(bone);
for i = 1 : 36
    cur_img = U(:, i);
    subplot(6,6,i);
    imagesc(reshape(cur_img,30,26));
    axis off
end

topEigenFaces = U(:, 1:50).';
projectedWeights = topEigenFaces * X;
recoveredFaces = topEigenFaces.' * projectedWeights;
figure
colormap(bone);
subplot(2,2,1);
imagesc(reshape(averageFace + X(:,11),30,26));
axis off
subplot(2,2,2);
imagesc(reshape(averageFace + recoveredFaces(:,11),30,26));
axis off

topEigenFaces = U(:, 1:10).';
projectedWeights = topEigenFaces * X;
recoveredFaces = topEigenFaces.' * projectedWeights;
subplot(2,2,3);
imagesc(reshape(averageFace + X(:,11),30,26));
axis off
subplot(2,2,4);
imagesc(reshape(averageFace + recoveredFaces(:,11),30,26));
axis off

%% Lecture 3 Silde 52

data = load('faces.mat');
X = data.X;

patchedImg = zeros(100,600);

for i = 1 : 600
    img = reshape(X(:,i),30,26);
    col = randi([1 21],1);
    row = randi([1 17],1);
    patch = img(col : col+9,row : row+9);
    patchedImg(:,i) = reshape(patch,100,1);
end    

%%Compute Average Patch
averagePatch = zeros(100,1);
for i = 1 : size(patchedImg,2)
    averagePatch = averagePatch + patchedImg(:,i);
end

averagePatch = averagePatch / size(patchedImg,2);

for i = 1 : size(patchedImg,2)
    patchedImg(:,i) = patchedImg(:,i) - averagePatch;
end

[U,S,V] = svd(cov(patchedImg.'));

figure
colormap(bone);
for i = 1 : 40
    cur_img = U(:, i);
    subplot(5,8,i);
    imagesc(reshape(cur_img,10,10));
    axis off
end

%% Lecture 6 Slide 22

a = -1;
b = 1;
N = 1000;
r1 = (b-a).*rand(N,1) + a;
r2 = (b-a).*rand(N,1) + a;
x = 2*r1 + r2;
y = r1 + r2;
data = [x,y];

% Compute PCA
[U, S, V] = svd(cov(data));
Z = U * data.';

% Compute ICA
W = eye(2,2);
I = eye(2,2);
alpha = 0.05;

for i = 1 : 3000
    Y =  W * (data.');
    fY = (Y).^3;
    tmp = fY * Y.';
    dw = ((I*N) - tmp) * W/N;
    W = W + alpha * dw;
end

icaData = W * data.';

figure
subplot(1,3,1);
plot(data(:,1), data(:,2), '.');
subplot(1,3,2);
plot(Z(1,:), Z(2,:), '.');
subplot(1,3,3);
plot(icaData(1,:), icaData(2,:), '.');
axis([-1.5 1.5 -1.5 1.5]);

%% Lecture 6 Slide 32

faces_data = load('faces.mat');
X = faces_data.X;

%Compute Average Face
averageFace = zeros(780,1);
for i = 1 : 600
    averageFace = averageFace + X(:,i);
end

averageFace = averageFace / 600;

for i = 1 : 600
    X(:,i) = X(:,i) - averageFace;
end

[U,S,V] = svd(cov(X.'));

postPca = U(:,1:16).' * X;

W = rand(16,16);
I = eye(16,16);
N = 600;

data = postPca;
size(data)
max_vals = max(data.').';
data = bsxfun(@rdivide,data,max_vals);

alpha = 0.001;
for i = 1 : 10000
    Y =  W * (data);
    fY = (Y).^3;
    tmp = fY * Y.';
    dw = ((I*N) - tmp) * W/N;
    W = W + alpha * dw;
end

icaFaces = W * U(:,1:16).';

figure
colormap(bone);
for i = 1 : 16
    cur_img = icaFaces(i,:);
    subplot(4,4,i);
    imagesc(reshape(cur_img,30,26));
    axis off
end

%% Lecture 6 Slide 45

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

W = rand(M,R);
H = rand(R,N);

for l = 1 : 40
WH = W * H + eps;

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

WH = W * H + eps;

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

end

figure
subplot(1,2,1);
plot(W(:,1));
view(-90,90)
subplot(1,2,2);
plot(W(:,2),'r');
view(-90,90)

figure
subplot(2,1,1);
plot(H(1,:));
subplot(2,1,2);
plot(H(2,:),'r');

%% Lecture 6 Slide 51, 52, 53

v = VideoReader('hands.mp4');

video = zeros(4800, 123);
i = 1;

while hasFrame(v)
    video(:, i) = reshape(rgb2gray(readFrame(v)),4800,1);
    i = i + 1;
end

% Compute PCA

[V,D] = eigs(cov(video.'));
postPca = V(:,1:3).' * video;
figure
subplot(3,1,1);
plot(postPca(1,:));
subplot(3,1,2);
plot(postPca(2,:),'r');
subplot(3,1,3);
plot(postPca(3,:),'g');

figure
colormap gray
subplot(1,3,1);
imagesc(reshape(V(:,1),60,80));
subplot(1,3,2);
imagesc(reshape(V(:,2),60,80));
subplot(1,3,3);
imagesc(reshape(V(:,3),60,80));

% Compute ICA
W = rand(3,3);
I = eye(3,3);
N = 123;

data = postPca;
size(data)
max_vals = max(data.').';
data = bsxfun(@rdivide,data,max_vals);

alpha = 0.0001;
for i = 1 : 15000
    Y =  W * (data);
    fY = (Y).^3;
    tmp = fY * Y.';
    dw = ((I*N) - tmp) * W/N;
    W = W + alpha * dw;
end

Z = W * postPca;
icaFaces = W * V(:,1:3).';

figure
subplot(3,1,1);
plot(Z(1,:));
subplot(3,1,2);
plot(Z(2,:),'r');
subplot(3,1,3);
plot(Z(3,:),'g');

figure
colormap gray
subplot(1,3,1);
imagesc(reshape(icaFaces(1,:),60,80));
subplot(1,3,2);
imagesc(reshape(icaFaces(2,:),60,80));
subplot(1,3,3);
imagesc(reshape(icaFaces(3,:),60,80));

%%%%NMF%%%

X = video;
M = size(X, 1);
N = size(X, 2);
R = 3;

W = rand(M,R);
H = rand(R,N);

for l = 1 : 120
WH = W * H + eps;

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

%WH = W * H + eps;

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

max_W = max(W);
W = bsxfun(@rdivide,W,max_W);

max_H = max(H.');
H = bsxfun(@rdivide,H.',max_H).';
end

figure
subplot(3,1,1);
plot(H(1,:));
subplot(3,1,2);
plot(H(2,:),'r');
subplot(3,1,3);
plot(H(3,:),'g');

figure
colormap gray
subplot(1,3,1);
imagesc(reshape(W(:,1),60,80));
subplot(1,3,2);
imagesc(reshape(W(:,2),60,80));
subplot(1,3,3);
imagesc(reshape(W(:,3),60,80));
end

