clear;
clc;
fd = load('matFiles/fd_sai_colored_bg_2.mat');
% Y = myNeuralNetworkFunction_sai_allcolors3(fd.global_samples_fd(:,:)); % 89%
Y = myNeuralNetworkFunction_sai_color_2(fd.global_samples_fd(:,:)); % 98 %
Y_target = load('matFiles/y_sai_colored_bg_2.mat');

match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)
