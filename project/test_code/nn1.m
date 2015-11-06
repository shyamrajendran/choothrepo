clearvars
folder = '/Users/saikat/Documents/UIUC/fall2015/MLSP/latest_repo/choothrepo/project/testhand/testimg/sai_hand2/';
[rmin, rmax, gmin,gmax, bmin, bmax] = calibrate(folder, 5);
labels = [];
global_samples_count = 0;
global_samples_fd = [];
for digit = 0:10
    basefolder = [folder, int2str(digit), '/'];
    fnames = dir([basefolder, '*.JPG']);
    numfiles = length(fnames);
    for count = 1:numfiles
        filename = fnames(count).name;
        datafile = [basefolder, filename];
        fd = generateFD(datafile, 0, rmin, rmax, gmin, gmax, bmin, bmax);
        if isempty(fd) == 0
            global_samples_count = global_samples_count + 1;
            labels(global_samples_count) = digit;
            global_samples_fd(:,global_samples_count) = fd;
        end
    end
end
Y = zeros(11, length(labels));
for i = 1:length(labels)
    Y(labels(i) + 1, i) = 1;
end
% save('fd_sai_hand2.mat', 'global_samples_fd');
% save('Y_sai_hand2.mat', 'Y');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%test on the trained data%%%%%%%%%%%%%%%%%%
fd = load('fd_sai_hand2.mat');
Y_target = load('Y_sai_hand2.mat');
Y = myNeuralNetworkFunction(fd.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
