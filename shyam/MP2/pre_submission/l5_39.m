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


