% v = VideoReader('~/Documents/MATLAB/ps2/hands.mp4');
v = VideoReader('/tmp/final123.mov');
i = 2;
frame = readFrame(v);

prevFrame = frame;
videoFrames(:,i-1) = prevFrame(:);

while hasFrame(v)
    frame = readFrame(v);
%     currFrame = frame(:,:,1);
    currFrame = frame;
    videoFrames(:,i) = currFrame(:);
    diff = abs(currFrame - prevFrame);
    rms = sqrt(mean(diff(:).^2));
    diffLog(1,i) = rms;
    i = i + 1;
    prevFrame = currFrame; 
end
%{
plot(diffLog);
vecdiffLog = diffLog(:);sm = smooth(vecdiffLog);diffLogSmooth = reshape(sm,1,163);plot(diffLogSmooth);
[indexes, mag]  = peakFinder(diffLogSmooth);


% figure,
% for i = 1:size(videoFrames,3)
%     subplot(10,10,i),
%     imagesc(videoFrames(1:720,1:450,i));
%     axis off;
%     if ( i == 100) break;
%     end
% end
%}
