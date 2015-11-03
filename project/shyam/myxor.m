% v = VideoReader('~/Documents/MATLAB/ps2/hands.mp4');
clear;
% colored towel
v = VideoReader('~/Desktop/ASL_MOVIEs/coloredTowel.mov');
length = 1619;
%

% % blue towel
% v = VideoReader('~/Desktop/ASL_MOVIEs/BlueTowel.mov');
% length = 1619;
% %

i = 2;
frame = readFrame(v);

prevFrame = frame;
videoFrames(:,i-1) = prevFrame(:);

while hasFrame(v)
    frame = readFrame(v);
    currFrame = frame;
    videoFrames(:,i) = currFrame(:);
    diff = abs(currFrame - prevFrame);
    rms = sqrt(mean(diff(:).^2));
    diffLog(1,i) = rms;
    i = i + 1;
    prevFrame = currFrame; 
end

plot(diffLog);vecdiffLog = diffLog(:);sm = smooth(vecdiffLog);diffLogSmooth = reshape(sm,1,length);plot(diffLogSmooth);
[indexes, mag]  = peakFinder(diffLogSmooth,0.5);
figure
j = 1;
for i = indexes
    image = reshape(videoFrames(:,i),720,1080,3);
    figure,imagesc(image);
    filename=sprintf('IMG_%d',j);
    name = strcat('/tmp/',filename,'.JPG')
    imwrite(image, name);
    j = j + 1;
end
