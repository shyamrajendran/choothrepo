function hands()

v = VideoReader('hands.mp4');
video = zeros(14400, 123);
i = 1;

while hasFrame(v)
    video(:, i) = reshape(readFrame(v),14400,1);
    i = i + 1;
end
%for i = 1 : 123
%    video(:,i) = reshape(read(v,i),14400,1);
%end

[V,D] = eigs(cov(video.'));
Z = V(:,1:3).' * video;
figure
plot(Z(1,:));
hold on
plot(Z(2,:),'r');
hold on
plot(Z(3,:),'g');

figure
colormap gray
subplot(1,3,1);
imagesc(reshape(V(:,1)*200,60,80,3));
subplot(1,3,2);
imagesc(reshape(V(:,2)*200,60,80,3));
subplot(1,3,3);
imagesc(reshape(V(:,3)*200,60,80,3));
end

