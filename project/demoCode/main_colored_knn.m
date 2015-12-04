
clear;clc;
%% toggle this 0 / 1 to run on saved mat files instead

rerun = 0;
% get digit frames images from peek
video_path = '/Users/sam/Box Sync/MLSP/project/movies/new_train/test_color.mov';
calib_path = 'project/testhand/testimg/new_training_sai/';
out_path = '/tmp/test_images';
frame_set_count = 30;
crop_data = load('crop_values_colored.mat');

if (rerun ~= 1) 
    [frame_set, frame_index, frame_timestamp ]  = grab_frames(video_path, crop_data.crop_values, frame_set_count, out_path, rerun);
    save('frame_data_colored.mat','frame_set','frame_index','frame_timestamp');
else
    load('frame_data_colored.mat');
end
%% generate Fourier Descriptor matrix 

total = 5;
% calibrated_data = calibrate(calib_path, total)
calibrated_data = struct();
calibrated_data.R_LOW = 1;
calibrated_data.R_HIGH = 1;
calibrated_data.G_LOW = 1;
calibrated_data.G_HIGH = 1;
calibrated_data.B_LOW = 1;
calibrated_data.B_HIGH = 1;

if ( rerun ~= 1) 
    global_samples_fd = gen_fd_dir_colored(out_path,calibrated_data);
    save('fd_data_colored.mat','global_samples_fd');
else
    load('fd_data_colored.mat');
end

%% prediction using K Nearest Neighbor
predicted_numbers = rot90(knn_test('fd_sai_colored_bg_2.mat','Y_sai_colored_bg_2.mat',global_samples_fd(:,:),5));

%% check prediction
dim = load('frame_dimension.mat');
checkFramePrediction(frame_set, predicted_numbers, dim);

%%



window_size = 10;
% window_size = 1;
maj_predicted = find_major_window(predicted_numbers, window_size);
time_stamp_start = grab_periodic(frame_timestamp, window_size,0);
time_stamp_end = grab_periodic(frame_timestamp, window_size,1);

frame_values = cell(1,3);
frame_values{1} = maj_predicted;
frame_values{2} = time_stamp_start;
frame_values{3} = time_stamp_end;
data = ['maj';'beg';'end'];
file_names = cellstr(data);


%% write each array into file
fid = fopen(file_names{1},'wt');  % Note the 'wt' for writing in text mode
fprintf(fid,'%d\n',frame_values{1});  % The format string is applied to each element of a
fclose(fid);
    
for i = 2:3 
    fid = fopen(file_names{i},'wt');  % Note the 'wt' for writing in text mode
    for j = 1 : length(frame_values{i})
        fprintf(fid,'%s\n',frame_values{i}{j});  % The format string is applied to each element of a
    end
    fclose(fid);
end
%%
%%% create SRT file with timestamps and predicted numbers with same name as video file
[out_srt_path, name, ext] = fileparts(video_path);
srt_file_name = strcat(out_srt_path,'/',name,'.srt');
fid=fopen(srt_file_name,'w');
commandStr = ['python gen_srt.py "' srt_file_name '" maj beg end']

[status, commandOut] = system(commandStr);
if status==0
     fprintf('srt file is at %s\n *MLSP BRA*',srt_file_name);
else
    disp('ERROR');
end
