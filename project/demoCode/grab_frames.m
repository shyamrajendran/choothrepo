function [frame_set, frame_index, frame_timestamp]  = grab_frames(video_path, crop_values, frame_set_count, out_path)
[status,message,messageid] = mkdir(out_path);

v = VideoReader(video_path);
actor_name = 'test';
frame_rate = v.FrameRate;

% init length frame
len = 1;
frame = readFrame(v);
prevFrame = frame;
disp('Begin diff frame finding');
load('diffLog.mat');

%%
% while hasFrame(v)
%     len
%     frame = readFrame(v);
%     currFrame = frame;
%     diff = abs(currFrame - prevFrame);
%     rms = sqrt(mean(diff(:).^2));
%     diffLog(1,len) = rms;
%     prevFrame = currFrame; 
%     if ( len == 50 ) 
%         break
%     end
%     len  = len + 1;
% end

    
% save('diffLog.mat','diffLog');
len = 50;

%%
len = 50;
disp('Begin peak finding');
vecdiffLog = diffLog(:);
sm = smooth(vecdiffLog);
diffLogSmooth = reshape(sm,1,len);
plot(diffLogSmooth);

[indexes, mag]  = peakFinder(diffLogSmooth,0.5);
figure
j = 1;

% init v again for use with read at specific frame
v = VideoReader(video_path);

for i = indexes
    begin_frame = i;
    end_frame = i+frame_set_count;
    while (begin_frame <= end_frame && begin_frame < len )
        findex = begin_frame;
        frame = read(v, findex);
        
        image = frame(crop_values.row_begin:crop_values.row_end,crop_values.col_begin:crop_values.col_end,1:3);
        frame_set(:,j) = image(:);
        frame_index(:,j) = findex;
        frame_timestamp(:,j) = findex/frame_rate;
        filename=sprintf('IMG_%d',j);
        name = strcat(out_path,'/',actor_name,'_',filename,'.JPG');
        imwrite(image, name);
        
        begin_frame = begin_frame + 1;
        j = j + 1;
    end 
end
end