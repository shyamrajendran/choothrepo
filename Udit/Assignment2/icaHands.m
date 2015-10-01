function icaHands()

v = VideoReader('hands.mp4');
video = zeros(14400, 123);
i = 1;

while hasFrame(v)
    video(:, i) = reshape(readFrame(v),14400,1);
    i = i + 1;
end

[V,D] = eigs(cov(video.'));
postPca = V(:,1:3).' * video;

W = randn(3,3);
I = eye(3,3);
N = 123;
data = postPca;

error = 0.0001;
rms = 1;
i = 0;
%for i = 1 : 3
%alpha = 0.05;
alpha = 1e-16;
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

Z = W * postPca;
figure
subplot(3,1,1);
plot(Z(1,:));
%hold on
subplot(3,1,2);
plot(Z(2,:),'r');
subplot(3,1,3);
plot(Z(3,:),'g');

end

