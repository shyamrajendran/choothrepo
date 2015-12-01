function checkFramePrediction(frame_set, predicted_set, dim)
no_frames = size(frame_set,2)
rows =  dim.frame_dimension(1);
cols =  dim.frame_dimension(2);
depth =  dim.frame_dimension(3);
for frame  = 1 : no_frames
    str = predicted_set(1,frame);
    frame,str
    if (mod(frame,10) == 0 )
        figure,imagesc(reshape(frame_set(:,frame), rows, cols, depth));,title(int2str(str))
    end
end
end