% v = VideoReader('~/Documents/MATLAB/ps2/hands.mp4');
clear;
% colored towel
% v = VideoReader('~/Desktop/ASL_MOVIEs/coloredTowel.mov');
% length = 1619;

%sai 
v = VideoReader('/Users/sam/choothrepo/project/movies/sam.mov');
actor_name = 'sam';

length = 1;
num_frames = 10;
sam_cropValues = struct();
sam_cropValues.row_begin = 1; 
sam_cropValues.row_end = 420;
sam_cropValues.col_begin = 50;
sam_cropValues.col_end = 500;

% xor_helper(actor_name, length, frametop, frameright, framebottomleft, framebottomright)
 i = 2;
    frame = readFrame(v);
    prevFrame = frame;
%     videoFrames(:,i-1) = prevFrame(:);

    while hasFrame(v)
%         length
        frame = readFrame(v);
        currFrame = frame;
%         videoFrames(:,i) = currFrame(:);
        diff = abs(currFrame - prevFrame);
        rms = sqrt(mean(diff(:).^2));
        diffLog(1,i) = rms;
        i = i + 1;
        prevFrame = currFrame; 
        length  = length + 1;
    end

    %%
    
    plot(diffLog);vecdiffLog = diffLog(:);sm = smooth(vecdiffLog);
    diffLogSmooth = reshape(sm,1,length);plot(diffLogSmooth);

    [indexes, mag]  = peakFinder(diffLogSmooth,0.5);
    figure
    j = 1;

    

    %%
    v = VideoReader('/Users/sam/choothrepo/project/movies/sam.mov');
    for i = indexes
        for im = 1:2
            findex = i+im;
            if (findex < length) 
                frame = read(v, findex);
%                 frame = reshape(videoFrames(:,i+im),720,1080,3);
                image = frame(sam_cropValues.row_begin:sam_cropValues.row_end,sam_cropValues.col_begin:sam_cropValues.col_end,1:3);
                filename=sprintf('IMG_%d',j);
                name = strcat('/tmp/',actor_name,'_',filename,'.JPG');
                imwrite(image, name);
                j = j + 1;
            end
        end
        figure,imagesc(image);
    end
    

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


