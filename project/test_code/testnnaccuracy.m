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



%%%%%%%%%%%%%%%all color hands sai, udit, sam
fd_sai = load('fd_sai_hand.mat');
fd_sam = load('fd_sam_hand.mat');
fd_udit = load('fd_udit_hand.mat');
fd_sai_cl = load('fd_sai_colored_bg.mat');
fd_sam_cl = load('fd_sam_colored_bg.mat');
fd_sai_sam_udit_all_colors = [fd_sai.global_samples_fd fd_sam.global_samples_fd ...
    fd_udit.global_samples_fd fd_sai_cl.global_samples_fd fd_sam_cl.global_samples_fd];

Y_sai_target = load('Y_sai_hand.mat');
Y_sam_target = load('Y_sam_hand.mat');
Y_udit_target = load('Y_udit_hand.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
Y_sam_col_target = load('Y_sam_colored_bg.mat');
Y_sai_sam_udit_all_colors = [Y_sai_target.Y Y_sam_target.Y Y_udit_target.Y ...
    Y_sai_col_target.Y Y_sam_col_target.Y];


% fd_sai_col = load('fd_sai_colored_bg.mat');
% Y_sai_col_target = load('Y_sai_colored_bg.mat');
% Y = myNeuralNetworkFunction_allcolors2(fd_sai_col.global_samples_fd(:,:));
% match = 0;
% for i = 1: size(Y,2)
%     [val,ind] = max(Y(:,i));
%     if Y_sai_col_target.Y(ind,i) == 1
%         match = match + 1;
%     end
% end
% accuracy = (match * 100 )/ size(Y,2)

fd_sam_col = load('fd_sam_colored_bg.mat');
Y_sam_col_target = load('Y_sam_colored_bg.mat');
Y = myNeuralNetworkFunction_all_colors(fd_sam_col.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sam_col_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)

fd_sai_col = load('fd_sai_colored_bg.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
Y = myNeuralNetworkFunction_all_colors(fd_sai_col.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sai_col_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)


% 
% %%%%%%%%%%%%%%%%%%%%%
% fd_sam_test = load('fd_sam_test.mat');
% y_sam_testtarget = load('y_sam_test.mat');
% % Y = myNeuralNetworkFunction_all_colors(fd_sam_test.global_samples_fd(:,:));
% Y = myNeuralNetworkFunction_sai_sam(fd_sam_test.global_samples_fd(:,:));
% match = 0;
% for i = 1: size(Y,2)
%     [val,ind] = max(Y(:,i));
%     if y_sam_testtarget.Y(ind,i) == 1
%         match = match + 1;
%     end
% end
% accuracy = (match * 100 )/ size(Y,2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fd_new = load('fd_sai_new.mat');
y_new = load('Y_sai_new.mat');
Y = myNeuralNetworkFunction_all_colors(fd_new.global_samples_fd(:,:));
% Y = myNeuralNetworkFunction_sai_sam(fd_sam_test.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if y_new.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)

% clear
fd_sai = load('fd_sai_hand.mat');
fd_sam = load('fd_sam_hand.mat');
fd_udit = load('fd_udit_hand.mat');
fd_sai_cl = load('fd_sai_colored_bg.mat');
fd_sam_cl = load('fd_sam_colored_bg.mat');
fd_new = load('fd_sai_new.mat');
fd_sai_sam_udit_all_colors2 = [fd_sai.global_samples_fd fd_sam.global_samples_fd ...
    fd_udit.global_samples_fd fd_sai_cl.global_samples_fd fd_sam_cl.global_samples_fd fd_new.global_samples_fd];

y_new = load('Y_sai_new.mat');
Y_sai_target = load('Y_sai_hand.mat');
Y_sam_target = load('Y_sam_hand.mat');
Y_udit_target = load('Y_udit_hand.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
Y_sam_col_target = load('Y_sam_colored_bg.mat');
Y_sai_sam_udit_all_colors2 = [Y_sai_target.Y Y_sam_target.Y Y_udit_target.Y ...
    Y_sai_col_target.Y Y_sam_col_target.Y y_new.Y];

Y_op = myNeuralNetworkFunction_allcolors2(fd_new.global_samples_fd(:,:));
% Y_op = myNeuralNetworkFunction_sai_sam(fd_new.global_samples_fd(:,:));
match = 0;

for i = 1: size(Y_op,2)
    [val,ind] = max(Y_op(:,i));
%     Y_op_label(i) = ind;
    if y_new.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)


fd_new = load('fd_sai_new.mat');
y_new = load('Y_sai_new.mat');
test_fd = fd_new.global_samples_fd;
y_fd = y_new.Y;
Y_op = myNeuralNetworkFunction_test(fd_new.global_samples_fd(:,:));
% Y_op = myNeuralNetworkFunction_sai_sam(fd_new.global_samples_fd(:,:));
match = 0;

for i = 1: size(Y_op,2)
    [val,ind] = max(Y_op(:,i));
%     Y_op_label(i) = ind;
    if y_new.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)

clearvars
fd_sai = load('fd_sai_hand.mat');
fd_sai_cl = load('fd_sai_colored_bg.mat');
fd_sai_new2 = load('fd_sai_new_2.mat');
fd_sai_all_colors2 = [fd_sai.global_samples_fd ...
    fd_sai_cl.global_samples_fd fd_sai_new2.global_samples_fd];

Y_sai_target = load('Y_sai_hand.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
Y_sai_new2 = load('Y_sai_new_2.mat');
Y_sai_all_colors2 = [Y_sai_target.Y ...
    Y_sai_col_target.Y Y_sai_new2.Y];

cur_fd = fd_sai_new2.global_samples_fd;
cur_Y = Y_sai_new2.Y;

fd_sai = load('fd_sai_hand.mat');
fd_sam = load('fd_sam_hand.mat');
fd_udit = load('fd_udit_hand.mat');
fd_sai_cl = load('fd_sai_colored_bg.mat');
fd_sam_cl = load('fd_sam_colored_bg.mat');
fd_new = load('fd_sai_new.mat');
fd_sai_new2 = load('fd_sai_new_2.mat');
fd_sai_sam_udit_all_colors3 = [fd_sai.global_samples_fd fd_sam.global_samples_fd ...
    fd_udit.global_samples_fd fd_sai_cl.global_samples_fd fd_sam_cl.global_samples_fd fd_new.global_samples_fd ...
    fd_sai_new2.global_samples_fd];


Y_sai_target = load('Y_sai_hand.mat');
Y_sam_target = load('Y_sam_hand.mat');
Y_udit_target = load('Y_udit_hand.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
Y_sam_col_target = load('Y_sam_colored_bg.mat');
y_new = load('Y_sai_new.mat');
Y_sai_new2 = load('Y_sai_new_2.mat');
Y_sai_sam_udit_all_colors3 = [Y_sai_target.Y Y_sam_target.Y Y_udit_target.Y ...
    Y_sai_col_target.Y Y_sam_col_target.Y y_new.Y Y_sai_new2.Y];

clearvars
fd_sai = load('fd_sai_hand.mat');
fd_sai_cl = load('fd_sai_colored_bg.mat');
fd_new = load('fd_sai_new.mat');
fd_sai_new2 = load('fd_sai_new_2.mat');
fd_sai_new3 = load('fd_sai_colored_bg_2.mat');
fd_sai_new33 = load('fd_sai_colored_bg_3.mat');
fd_sai_all_colors5 = [fd_sai.global_samples_fd ...
    fd_sai_cl.global_samples_fd fd_new.global_samples_fd ...
    fd_sai_new2.global_samples_fd fd_sai_new3.global_samples_fd fd_sai_new33.global_samples_fd];


Y_sai_target = load('Y_sai_hand.mat');
Y_sai_col_target = load('Y_sai_colored_bg.mat');
y_new = load('Y_sai_new.mat');
Y_sai_new2 = load('Y_sai_new_2.mat');
Y_sai_new3 = load('Y_sai_colored_bg_2.mat');
Y_sai_new33 = load('Y_sai_colored_bg_3.mat');
Y_sai_all_colors5 = [Y_sai_target.Y ...
    Y_sai_col_target.Y y_new.Y Y_sai_new2.Y Y_sai_new3.Y Y_sai_new33.Y];
match = 0;
Y = myNeuralNetworkFunction_sai_allcolors5(fd_sai_new33.global_samples_fd(:,:));
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sai_new33.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)

clearvars
fd_sai_new33 = load('fd_sai_colored_bg_3.mat');
Y_sai_new33_target = load('Y_sai_colored_bg_3.mat');
Y = myNeuralNetworkFunction_sai_allcolors5(fd_sai_new33.global_samples_fd(:,:));
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if Y_sai_new33_target.Y(ind,i) == 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2)