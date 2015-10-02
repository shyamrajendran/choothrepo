%% lecture 5 - slide 25
clearvars
FigHandle = figure('name','lecture 5 - 25','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);
N = 1000;
x1 = 4 * randn(N,1);
y1 = 1 * randn(N,1);
R = [cosd(145) -sind(145); sind(145) cosd(145)];
scaling = [x1, y1] * R;
x1 = scaling(:,1);
y1 = scaling(:,2);

data = [x1 y1];
X = data.';

subplot(1,2,1);
scatter(x1,y1);

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


%% lecture 5 - slide 37
clearvars
FigHandle = figure('name','lecture 5 - 37','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 600, 500]);

load faces.mat;
cov_x = cov(X.');
[U,S,V] = svd(cov_x);
for i = 1:36
    subplot(6,6,i);
    img = reshape(U(:,i),M,N);
    imagesc(img),colormap(bone);axis off; 
end
%% lecture 5 - slide 39
clearvars
FigHandle = figure('name','lecture 5 - slide 39','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 200]);

load faces.mat;

[H,V] = size(X);
INPUT = X;
subplot(1,6,1);
imagesc(reshape(INPUT(:,11),M,N)),colormap(bone),title('input');


%% taking mean face reduction
mean_face_vector = sum(X,2) / V;
mean_face = reshape(mean_face_vector,M,N);
% figure,imagesc(mean_face),colormap(bone);
for i = 1:V
    X(:,i) = X(:,i) - mean_face_vector;
end

%% Taking PCA
cov_x = cov(X.');
[U,S,V] = svd(cov_x);

%% for k = 50
k = 50;
U50 = U(:,1:k);
U50T = U50.';
size(U50T)
W = U50T*X;
recoveredFaces = U50T.' * W;
size(recoveredFaces)
approxFace = reshape(recoveredFaces(:,11),M,N);


subplot(1,6,2);
imagesc(U50T(:,11)),colormap gray,title('Weights');


subplot(1,6,3)
imagesc(approxFace+mean_face),colormap(bone),title('Approximation');

%% for k = 10
k = 10;
U10 = U(:,1:k);
U10T = U10.';
W = U10T*X;
recoveredFaces = U10T.' * W;
approxFace = reshape(recoveredFaces(:,11),M,N);

subplot(1,6,4);
imagesc(reshape(INPUT(:,11),M,N)),colormap(bone),title('input');


subplot(1,6,5)
imagesc(U10T(:,11)),colormap(bone),title('Weight');

subplot(1,6,6)
imagesc(approxFace+mean_face),colormap(bone), title('Approximation');

%% lecture 5 - slide 52
clearvars
FigHandle = figure('name','lecture 5 - slide 52','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);

load faces.mat;

[H,V] = size(X);
for i = 1:V
    imageTensor(:,:,i) = reshape(X(:,i),M,N);
end

xrange = [1 15];
yrange = [1 15];
%patchTensor
for i = 1:V
    x = uint8(rand(1,1)*range(xrange)+min(xrange));
    y = uint8(rand(1,1)*range(yrange)+min(yrange));
    imag = imageTensor(:,:,i);
    % taking patch of 10x10 size random
    patch = imag(x:x+9,y:y+9);
    patchTensor(:,:,i) = patch;
end

for i = 1:V
    p = patchTensor(:,:,i);
    inp(:,i) = p(:);
end

X = inp;
cov_x = cov(X.');
[U,S,V] = svd(cov_x);
for i = 1:50
    subplot(5,10,i);
    imagesc(reshape(U(:,i),10,10)),colormap(bone);axis off;
end

%% lecture 6 - slide 22
clearvars
FigHandle = figure('name','lecture 6 - 22','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1300, 300]);

N = 1000;
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
scatter(op(1,:),op(2,:),'o'),title('ICA');

%% lecture 6 - slide 32
clearvars
load faces.mat;
[H,V] = size(X);
INPUT = X;

mean_face_vector = sum(X,2) / V;
mean_face = reshape(mean_face_vector,M,N);
% figure,imagesc(mean_face),colormap(bone);
for i = 1:V
    X(:,i) = X(:,i) - mean_face_vector;
end

cov_x = cov(X.');
[U,S,V] = svd(cov_x);
PCA_eigen = U;

FigHandle = figure('name','EIGEN FACES','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 500, 500]);
for i = 1:16
    subplot(4,4,i);
    img = reshape(PCA_eigen(:,i),30,26);
    imagesc(img),colormap(bone);axis off;
end

ICA_INPUT = U(:,1:16).'*X;
W = rand(16);
D = eye(16);
learningRate = 1e-16;
delta = 0.00001;
N = 1000;
% normalize it
max_vals = max(ICA_INPUT.').';
ICA_INPUT = bsxfun(@rdivide,ICA_INPUT,max_vals);

W = helperICA(learningRate, delta, W, ICA_INPUT, D, N);
op = W * U(:,1:16).';
op = op.'; % to match slide sequence of faces
FigHandle = figure('name','ICA FACES','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 500, 500]);
for i = 1:16
   subplot(4,4,i);
   img = reshape(op(:,i),30,26);
   imagesc(img),colormap(bone);axis off;
end
%% lecture 6 - slide 45
clearvars
in = zeros(100,200);
for i = 2:23
    for j = 2:23
        in(i,j) = 1;
    end
end

for i = 2:23
    for j = 50:90
        in(i,j) = 1;
    end
end

for i = 2:23
    for j = 130:160
        in(i,j) = 1;
    end
end

for i = 2:23
    for j = 183:200
        in(i,j) = 1;
    end
end

for i = 80:90
    for j = 20:40
        in(i,j) = 1;
    end
end

for i = 80:90
    for j = 80:110
        in(i,j) = 1;
    end
end

for i = 80:90
    for j = 150:180
        in(i,j) = 1;
    end
end
imagesc(imcomplement(in)),colormap gray;
axis xy

errorrate = 1e-5;
X = double(in);
H = rand(2,200)+10;
W = rand(100, 2)+10;
N = 500;
[output,W,H,N] = nmf_helper(X,W,H,N,errorrate);
figure
subplot(4,1,1)
plot(W(:,1)),title('Sometimes due to the randomness, it needs to be rerun for proper output - W column 1');
subplot(4,1,2)
plot(W(:,2)),title('W column 2');
subplot(4,1,3)
plot(H(1,:)),title('H ROW 1');
subplot(4,1,4)
plot(H(2,:)),title('H ROW 2');

%% lecture 6 - slide 51,52,53
clearvars
file = 'hands.mp4';
v = VideoReader(file);
i = 1;
while hasFrame(v)
    frame = readFrame(v);
    grayScale = rgb2gray(frame);
    video(:,i) = grayScale(:);
    i = i + 1;
end
X = double(video);
size(video)
[U,D] = eigs(cov(X.'));
size(X)
U = U(:,1:3);
UT = U.';
Z = UT*X;
figure('name','lecture 6 - slide 51','numbertitle','off');
subplot(2,3,1)
ut = reshape(U(:,1),60,80);
imagesc(ut*240),colormap bone,title('Component 1');

subplot(2,3,2)
ut = reshape(U(:,2),60,80);
imagesc(ut*240),colormap bone,title('Component 2');

subplot(2,3,3)
ut = reshape(U(:,3),60,80);
imagesc(ut*240),colormap bone,title('Component 3');

figure('name','lecture 6 - slide 51','numbertitle','off');
plot(Z(1,:))
hold on
plot(Z(2,:))
hold on
plot(Z(3,:))
hold off
W = rand(3);
D = eye(3);

learningRate = 1e-16;
delta = 0.0001;
N = 150;
W = helperICA(learningRate, delta, W, Z, D, N);
op = W * U.';
Z = op * X;

figure('name','lecture 6 - slide 52','numbertitle','off');
subplot(1,3,1)
imagesc(reshape(op(1,:), 60,80) .* 300), colormap bone,title('ICA component1');
subplot(1,3,2)
imagesc(reshape(op(2,:), 60,80) .* 300), colormap bone, title('ICA component2');
subplot(1,3,3)
imagesc(reshape(op(3,:), 60,80) .* 300), colormap bone, title('ICA component3');

figure('name','lecture 6 - slide 52','numbertitle','off');
subplot(3,1,1)
plot(Z(1,:))
subplot(3,1,2)
plot(Z(2,:))
subplot(3,1,3)
plot(Z(3,:))
errorrate = 1e-5;
H = rand(3, 123) + 10;
W = rand(4800, 3) + 10;
N = 50;

[output,W,H,N] = nmf_helper(X,W,H,N,errorrate);


figure('name','lecture 6 - slide 53','numbertitle','off');
subplot(2,3,1);
ut = reshape(W(:,1),60,80);
imagesc(ut),colormap gray

subplot(2,3,2)
ut = reshape(W(:,2),60,80);
imagesc(ut),colormap gray

subplot(2,3,3)
ut = reshape(W(:,3),60,80);
imagesc(ut),colormap gray


figure('name','lecture 6 - slide 53','numbertitle','off');
subplot(3,1,1)
plot(H(1,:)), title('comp 1');
subplot(3,1,2)
plot(H(2,:)), title('comp 2');
subplot(3,1,3)
plot(H(3,:)), title('comp 3');

%% lecture 7 - slide 36
clearvars
load('cities.mat');
%%
in = D;
[r,c] = size(in);
for i = 1:r
    sum = 0;
    for j = 1:c
        sum = sum + in(i,j);
    end
    avg = sum/c;
    avg
    for j = 1:c
        in(i,j) = in(i,j)-avg; 
    end
    avg = 0;
end

for j = 1:c
    sum = 0;
    for i = 1:r
        sum = sum + in(i,j);
    end
    avg = sum/r;
    for i = 1:r
        in(i,j) = in(i,j)-avg; 
    end
end


[U,S,V] = svd(cov(in));
% taking only top 3 components 
U = U(:,1:3);
Z = U.'*in;
X1 = Z(1,:);
Y1 = Z(2,:);
Z1 = Z(3,:);
%%
FigHandle = figure('name','lecture 7 - 26','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 400]);
subplot(1,2,1)
imagesc(in);colormap gray;axis xy;
subplot(1,2,2)
scatter3(Y1,Z1,X1);
text(Y1,Z1,X1,cities);

%% lecture 7 - slide 56
clearvars
FigHandle = figure('name','lecture 7 - slide 56','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);
N = 2^10;
cmap = jet(N);
t = rand(1,N);
t = sort(4*pi*sqrt(t))'; 
z = 8*pi*rand(N,1); 
x = (t+.1).*cos(t);
y = (t+.1).*sin(t);
data = [x,y,z];
subplot(2,3,1)
scatter3(x,y,z,20,cmap);
view([-12,-82]);
title('input data');

W = zeros(N);
sigma = 100;

% finding the distance between points
for i = 1:N
    for j = 1:N
        d1 = (x(i)-x(j)).^2;
        d2 = (y(i)-y(j)).^2;
        d3 = (z(i)-z(j)).^2;
        d = d1+d2+d3;
        e = exp((-1*d)/sigma);
        W(i,j) = e;    
    end
end
% figure,imagesc(W);colormap gray;
tw = zeros(N);

neighboursTrials = [4 10 25 45];
index = 2;
for neighbours = neighboursTrials
    for i = 1:N
        [sort_data, sort_index] = sort(W(i,:),'descend');
        for j = 2:neighbours
            max_index = sort_index(1,j);
            tw(i,max_index) = sort_data(1,j);
        end
    end
   % figure,imagesc(tw);
    onet = ones(N,1).';
    rs = onet*tw;
    D = diag(rs);
    L = tw - D;
    for i = 1:N
        if (rs(1,i) ~= 0) 
            rs(1,i) = rs(1,i).^(-0.5);
        end
    end
    D1 = diag(rs);
    Lchandra = (D1*L*D1);
    % figure,imagesc(Lchandra);
    [U,S,V] = svd(Lchandra);
    subplot(2,3,index);
    scatter(U(:,N-1),U(:,N-2),50,cmap),axis ij, title(['neighbour k  =',int2str(neighbours)]);
    view([0,-88]);
    index = index + 1;
end
%% lecture 7 - slide 68
clearvars

FigHandle = figure('name','lecture 7 - 68','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1200, 300]);

file = 'hotlips.mp4';
v = VideoReader(file);
i = 1;

while hasFrame(v)
    frame = readFrame(v);
    grayScale = rgb2gray(frame);
    video(:,i) = grayScale(:);
    i = i + 1;
end
X = double(video);
[H,V,P] = size(frame);
N = 86;
W = zeros(N);
for i = 1:N
    frame1 = X(:,i);
    for j = 1:N
        frame2 = X(:,j);
        costheta = dot(frame1,frame2)/(norm(frame1)*norm(frame2));
%         theta = acos(costheta);
        W(i,j) = costheta;
    end
end
index = 1;
tw = zeros(N);
neighboursTrials = [2 4 8 25];
for neighbours = neighboursTrials
    for i = 1:N
        [sort_data, sort_index] = sort(W(i,:),'descend');
        for j = 2:neighbours
            max_index = sort_index(1,j);
            tw(i,max_index) = sort_data(1,j);
        end
    end
    % figure, imagesc(tw),colormap gray;


    onet = ones(N,1).';
    rs = onet*tw;
    D = diag(rs);
    L = tw - D;
    for i = 1:N
        if (rs(1,i) ~= 0) 
            rs(1,i) = rs(1,i).^(-0.5);
        end
    end
    D1 = diag(rs);
    Lchandra = (D1*L*D1);
    % figure,imagesc(Lchandra);
    [U,S,V] = svd(Lchandra);
    cmap = jet(N);
    subplot(1,4,index)
    scatter(U(:,N-1),U(:,N-2),50,cmap),colormap gray, title(['neighbours k=',int2str(neighbours)]);
    index = index + 1;
end
%% extra question
clearvars
load one.mat;
[R, C] = size(one);

for i = 1:C
    input(:,i) = one{i}(:);
end

X = input;

N = 1135;
for i = 1:N
    frame1 = X(:,i);
    for j = 1:N
        frame2 = X(:,j);
        costheta = dot(frame1,frame2)/(norm(frame1)*norm(frame2));
%         theta = acos(costheta);
        W(i,j) = costheta;
    end
end
tw = zeros(N);
neighbours = 100;
for i = 1:N
    [sort_data, sort_index] = sort(W(i,:),'descend');
    for j = 2:neighbours
        max_index = sort_index(1,j);
        tw(i,max_index) = sort_data(1,j);
    end
end
% figure, imagesc(tw),colormap gray;


onet = ones(N,1).';
rs = onet*tw;
D = diag(rs);
L = tw - D;
for i = 1:N
    if (rs(1,i) ~= 0) 
        rs(1,i) = rs(1,i).^(-0.5);
    end
end
D1 = diag(rs);
Lchandra = (D1*L*D1);
% figure,imagesc(Lchandra);
[U,S,V] = svd(Lchandra);
cmap = jet(N);
figure('name','extra credit question','numbertitle','off');
scatter(U(:,N-1),U(:,N-2)),colormap gray, title('I can observe that when LE is applied on the input data, ones.mat and project it down to 2 dimension, the pattern of 1 is clearly seen');

