% v = VideoReader('~/Documents/MATLAB/ps2/hands.mp4');
clear;
% colored towel
% v = VideoReader('~/Desktop/ASL_MOVIEs/coloredTowel.mov');
% length = 1619;

%sai 
v = VideoReader('/tmp/sai.mov');
actor_name = 'sai';
length = 734;

frametop = 1; 
frameright = 320;
framebottomleft = 50;
framebottomright = 600;

% xor_helper(actor_name, length, frametop, frameright, framebottomleft, framebottomright)
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

    {
    plot(diffLog);vecdiffLog = diffLog(:);sm = smooth(vecdiffLog);
    diffLogSmooth = reshape(sm,1,length);plot(diffLogSmooth);

    [indexes, mag]  = peakFinder(diffLogSmooth,0.5);
    figure
    j = 1;

    for i = indexes
        for im = 1:10
            if (i+im < length) 
                image = reshape(videoFrames(:,i+im),720,1080,3);
                image = image(frametop:frameright,framebottomleft:framebottomright,1:3);
                filename=sprintf('IMG_%d',j);
                name = strcat('/tmp/',actor_name,'_',filename,'.JPG');
                imwrite(image, name);
                j = j + 1;
            end
        end
        figure,imagesc(image);
    end
    }

%udit
% v = VideoReader('/tmp/udit.mov');
% length = 975;
% actor_name = 'udit';
% 
% frametop = 1; 
% frameright = 420;
% framebottomleft = 50;
% framebottomright = 600;

%shyam
% v = VideoReader('/tmp/sam.mov');
% length = 1393;
% 
% actor_name = 'sam';
% frametop = 1; 
% frameright = 420;
% framebottomleft = 50;
% framebottomright = 550;
% 

% suhas
% v = VideoReader('/tmp/suhas.mov');
% length = 637;
% actor_name = 'suhas';
% frametop = 1; 
% frameright = 420;
% framebottomleft = 200;
% framebottomright = 700;


