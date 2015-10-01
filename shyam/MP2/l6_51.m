%% input
FigHandle = figure('name','lecture 5 - 25','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);
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
%%

% taking PCA 


%{
[U,D] = eigs(cov(X.'));

size(X)
U = U(:,1:3);
UT = U.';
Z = UT*X;

subplot(2,3,1)
ut = reshape(U(:,1),60,80);
imagesc(ut*240),colormap bone

subplot(2,3,2)
ut = reshape(U(:,2),60,80);
imagesc(ut*240),colormap bone

subplot(2,3,3)
ut = reshape(U(:,3),60,80);
imagesc(ut*240),colormap bone

figure
plot(Z(1,:))
hold on
plot(Z(2,:))
hold on
plot(Z(3,:))
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% do ICA
W = rand(3);
D = eye(3);

learningRate = 1e-16;
delta = 0.0001;
N = 123;
W = helperICA(learningRate, delta, W, Z, D, N);
op = W * Z;
subplot(3,1,1)
plot(op(1,:))
subplot(3,1,2)
plot(op(2,:))
subplot(3,1,3)
plot(op(3,:))
%}

%% nmf
errorrate = 1e-5;
% X = double(in);
H = rand(3, 123);
W = rand(4800, 3);
N = 50;

[output,W,H,N] = nmf_helper(X,W,H,N,errorrate);

% U = output;

subplot(2,3,1);
ut = reshape(W(:,1),60,80);
imagesc(ut*240),colormap bone

subplot(2,3,2)
ut = reshape(W(:,2),60,80);
imagesc(ut*240),colormap bone

subplot(2,3,3)
ut = reshape(W(:,3),60,80);
imagesc(ut*240),colormap bone


figure
subplot(3,1,1)
plot(H(1,:))
subplot(3,1,2)
plot(H(2,:))
subplot(3,1,3)
plot(H(3,:))
