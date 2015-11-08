fd_sai = load('fd_sai_hand.mat');
fd_sam = load('fd_sam_hand.mat');
fd_sai_sam = [fd_sai.global_samples_fd fd_sam.global_samples_fd];

Y_sai_target = load('Y_sai_hand.mat');
Y_sam_target = load('Y_sam_hand.mat');
Y_sai_sam = [Y_sai_target.Y Y_sam_target.Y];


Y = myNeuralNetworkFunction_sai_sam(fd_sam.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sam_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)


fd_sai


%%%train on sam hand test with sai hand
Y = myNeuralNetworkFunction_sam(fd_sai.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sai_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)


%%%train on sam hand test with sai hand
Y = myNeuralNetworkFunction_sai(fd_sam.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sam_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)


fd_udit = load('fd_udit_hand.mat');
Y_udit_target = load('Y_udit_hand.mat');
Y_sai_sam_udit = [Y_sai_target.Y Y_sam_target.Y Y_udit_target.Y];
fd_sai_sam_udit = [fd_sai.global_samples_fd fd_sam.global_samples_fd fd_udit.global_samples_fd];

Y = myNeuralNetworkFunction_sai_sam_udit(fd_sai.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sai_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)


fd_sai_col = load('fd_sai_colored_bg.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
Y = myNeuralNetworkFunction_sai_sam_udit(fd_sai_col.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sai_col_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)
