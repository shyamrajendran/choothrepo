clearvars
folder = '/Users/saikat/Documents/UIUC/fall2015/MLSP/latest_repo/choothrepo/project/testhand/testimg/sai_colored_bg/';
[rmin, rmax, gmin,gmax, bmin, bmax] = calibrate(folder, 5);
labels = [];
global_samples_count = 0;
global_samples_fd = [];
tic;
for digit = 0:10
    basefolder = [folder, int2str(digit), '/'];
    fnames = dir([basefolder, '*.JPG']);
    numfiles = length(fnames);
    for count = 1:numfiles
        filename = fnames(count).name;
        datafile = [basefolder, filename];
        fd = generateFDfromfile(datafile, 0, rmin, rmax, gmin, gmax, bmin, bmax);
        if isempty(fd) == 0
            global_samples_count = global_samples_count + 1;
            labels(global_samples_count) = digit;
            global_samples_fd(:,global_samples_count) = fd;
        end
    end
end
toc
Y = zeros(11, length(labels));
for i = 1:length(labels)
    Y(labels(i) + 1, i) = 1;
end
save('fd_sai_colored_bg.mat', 'global_samples_fd');
save('Y_sai_colored_bg.mat', 'Y');
