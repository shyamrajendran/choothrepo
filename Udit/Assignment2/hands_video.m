function hands_video()

v = VideoReader('hands.mp4');

video = zeros(4800, 123);
i = 1;

while hasFrame(v)
    video(:, i) = reshape(rgb2gray(readFrame(v)),4800,1);
    i = i + 1;
end

[V,D] = eigs(cov(video.'));
postPca = V(:,1:3).' * video;
figure
plot(postPca(1,:));
hold on
plot(postPca(2,:),'r');
hold on
plot(postPca(3,:),'g');

figure
colormap gray
subplot(1,3,1);
imagesc(reshape(V(:,1)*200,60,80));
subplot(1,3,2);
imagesc(reshape(V(:,2)*200,60,80));
subplot(1,3,3);
imagesc(reshape(V(:,3)*200,60,80));

W = randn(3,3);
I = eye(3,3);
N = 123;

data = postPca;
size(data)
max_vals = max(data.').';
data = bsxfun(@rdivide,data,max_vals);

error = 0.0000001;
rms = 1;
i = 0;
for i = 1 : 10000
alpha = 0.000001;
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
Z = W * postPca;
icaFaces = W * V(:,1:3).';

figure
subplot(3,1,1);
plot(Z(1,:));
%hold on
subplot(3,1,2);
plot(Z(2,:),'r');
subplot(3,1,3);
plot(Z(3,:),'g');

figure
colormap gray
subplot(1,3,1);
imagesc(reshape(icaFaces(1,:)*200,60,80));
subplot(1,3,2);
imagesc(reshape(icaFaces(2,:)*200,60,80));
subplot(1,3,3);
imagesc(reshape(icaFaces(3,:)*200,60,80));


%%%%NMF%%%
%{
X = video;
M = size(X, 1);
N = size(X, 2);
R = 3;

W = rand(M,R);
H = rand(R,N);
Wlast = W;
Hlast = H;
rmsWH = 1;

iter = 0;
error = 1e-04;
for l = 1 : 70
%while rmsWH > error
iter = iter + 1;
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

%rmsW = convergence(W,Wlast);
%rmsH = convergence(H,Hlast);
rmsWH = convergence(W * H,Wlast * Hlast);

max_W = max(W);
W = bsxfun(@rdivide,W,max_W);

max_H = max(H.');
H = bsxfun(@rdivide,H.',max_H).';
%iter, rmsWH
Wlast = W;
Hlast = H;
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
%}
end

