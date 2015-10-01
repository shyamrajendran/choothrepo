function icaFaces()

load('faces.mat');

T = X;
%Compute Average Face
averageFace = zeros(780,1);
for i = 1 : 600
    averageFace = averageFace + X(:,i);
end

averageFace = averageFace / 600;

figure
colormap(bone);
imagesc(reshape(averageFace,30,26));

for i = 1 : 600
    X(:,i) = X(:,i) - averageFace;
end

[U,S,V] = svd(cov(X.'));
%[U,S,V] = svd(X);
figure
colormap(bone);
for i = 1 : 36
    cur_img = U(:, i);
    subplot(6,6,i);
    imagesc(reshape(cur_img,30,26));
    axis off
end

postPca = U(:,1:16).' * X;
%size(postPca)

%W = eye(16,16);
W = rand(16,16);
%W = randn(16,16);
I = eye(16,16);
N = 600;
data = postPca;

error = 0.0001;
rms = 1;
i = 0;
% i = 1 : 10000
alpha = 1e-16;
%alpha = 1e-15;
while rms > error
    i = i + 1;
    i
    Y =  W * (data);
    fY = (Y).^3;
    tmp = fY * Y.';
    dw = ((I*N) - tmp) * W/N;
    Wlast = W;
    W = W + alpha * dw;
    rms = convergence(W, Wlast);
    rms
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

end

