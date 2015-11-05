close all
clearvars
count = 220;
display = 1;
filename = '/Users/saikat/Documents/UIUC/fall2015/MLSP/choothrepo/project/testhand/testimg/sai_hand2/';
global_fd_train1 = test_rotation(1, count, filename, 0);
global_fd_train1 = global_fd_train1.';



labelfile = [filename, 'label.txt'];
classop = load(labelfile);
%%% classes 0-10
Y_sai_hand2 = zeros(11, size(global_fd_train1,2)); 
for i = 1:length(classop)
    Y_sai_hand2(classop(i) + 1, i) = 1;
end


filename = '/Users/saikat/Documents/UIUC/fall2015/MLSP/choothrepo/project/testhand/testimg/sai_hand2/';
fd = load('sai_hand2_fd.mat');
Y = myNeuralNetworkFunction(fd.global_fd_train1);
match = 0;
for i = 1: size(Y,2)
    [val,ind] = max(Y(:,i));
    if ind == classop(i) + 1
        match = match + 1;
    end
end
accuracy = (match * 100 )/ size(Y,2);
