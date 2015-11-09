clear

%% get digit frames +5 images from peek

video_path = '/Users/sam/choothrepo/project/movies/sam.mov';
calib_path = '/Users/sam/choothrepo/project/demoCode/calib_images/';
out_path = '/tmp/test_images';
frame_set_count = 3;
crop_data = load('crop_values.mat');
[frame_set, frame_index, frame_timestamp ]  = grab_frames(video_path, crop_data.crop_values, frame_set_count, out_path);

%% generate Fourier Descriptor matrix 

total = 5;
calibrated_data = calibrate(calib_path, total)
global_samples_fd = gen_fd_dir(out_path,calibrated_data);

%% prediction using NN
Y = myNeuralNetworkFunction_sai_sam(global_samples_fd);
predicted_numbers = zeros(1,size(Y,2));
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i)); 
    predicted_numbers(1,i) = ind;
end
%%
maj_predicted = find_major_window(predicted_numbers, frame_set_count);
time_stamp_start = grab_periodic(frame_timestamp, frame_set_count,0);
time_stamp_end = grab_periodic(frame_timestamp, frame_set_count,1);

%% create SRT file with timestamps and predicted numbers with same name as video file
[out_srt_path, name, ext] = fileparts(video_path);
srt_file_name = strcat(out_srt_path,'/',name,'.srt');
fid=fopen(srt_file_name,'w');

commandStr = sprintf('%s,'python',' ','gen_srt.py',' ',maj_predicted,' ',time_stamp_start,' ',time_stamp_end);
%%
[status, commandOut] = system(commandStr);
if status==0
     fprintf('srt file is at %s\n',srt_file_name);
 end

