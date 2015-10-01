function icaFacesNew()

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
%W = rand(16,16);
W = rand(16,16);
I = eye(16,16);
N = 600;

data = postPca;
size(data)
max_vals = max(data.').';
data = bsxfun(@rdivide,data,max_vals);

error = 0.00001;
rms = 1;
i = 0;
for i = 1 : 6000
alpha = 0.0001;
%while rms > error
    i = i + 1;
    Y =  W * (data);
    fY = (Y).^3;
    tmp = fY * Y.';
    dw = ((I*N) - tmp) * W/N;
    Wlast = W;
    W = W + alpha * dw;
    rms = convergence(W, Wlast);
    %rms
end

W
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

