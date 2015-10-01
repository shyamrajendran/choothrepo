
FigHandle = figure('name','lecture 5 - 25','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);
file = 'hands.mp4';
v = VideoReader(file);
i = 1;

while hasFrame(v)
    frame = readFrame(v);
    video(:,i) = frame(:);
    i = i + 1;
end

% taking PCA 
X = double(video);
size(video)
H = 60;
V = 80;
P = 3;
frameSize = H*V*P;
components = 3;
frames = 123;

H = rand(components,frames);
W = rand(frameSize, components);

[rW, cW] = size(W);
[rH, cH] = size(H);

%{
W =W ? Xi,k H i,j i,j k (W?H) j,k
?H =H ?W
j,k j,k i i,j (W?H)i,k
%}

figure



subplot(3,1,1)
plot(H(1,:))
subplot(3,1,2)
plot(H(2,:))
subplot(3,1,3)
plot(H(3,:))

WH = W*H;
imagesc(reshape(W(:,3),60,80,3)*0.001)



