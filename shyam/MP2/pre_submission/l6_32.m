
load faces.mat;

[H,V] = size(X);
INPUT = X;


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
PCA_eigen = U;


%%
%plotting EigenFaces
for i = 1:16
    subplot(4,4,i);
    img = reshape(PCA_eigen(:,i),30,26);
    imagesc(img),colormap(bone);axis off;
end


%% Taking only 16 dimensions
ICA_INPUT = U(:,1:16).'*X;
%% computing ICA
W = randn(16);
D = eye(16);
learningRate = 1e-16;
delta = 0.00001;
N = 1000;

W = helperICA(learningRate, delta, W, ICA_INPUT, D, N);

op = W * ICA_INPUT;
op = X(:,1:16)*op;
size(op)
figure
for i = 1:16
   subplot(4,4,i);
   img = reshape(op(:,i),30,26);
   imagesc(img+mean_face),colormap(bone);axis off;
end


