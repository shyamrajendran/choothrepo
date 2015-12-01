function fd_op = gen_fd_dir_colored(out_path,calibrated_data)

name = strcat(out_path,'/','*.jpg');
jpgFiles = dir(name);
numFiles = length(jpgFiles);
mydata = cell(1,numFiles);

for k = 1:numFiles
    file_name = strcat(out_path,'/',jpgFiles(k).name);
    mydata{k} = imread(file_name);
end

fd_op = zeros(64, numFiles);
count = 1;
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp('************ Entering FD generation loop ***************');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
for k = 1:numFiles
    im = mydata{k};
    count
    if (mod(count,10) == 0 ) 
        fd = generateFD_colored(im, 1, calibrated_data.R_LOW, calibrated_data.R_HIGH, calibrated_data.G_LOW, calibrated_data.G_HIGH, calibrated_data.B_LOW, calibrated_data.B_HIGH);
    else
        fd = generateFD_colored(im, 0,calibrated_data.R_LOW, calibrated_data.R_HIGH, calibrated_data.G_LOW, calibrated_data.G_HIGH, calibrated_data.B_LOW, calibrated_data.B_HIGH);
    end
    count = count + 1;
    fd_op(:,k) = fd;
end
end