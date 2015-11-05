close all
clearvars
count = 10;
filename = '/Users/saikat/Documents/UIUC/fall2015/MLSP/choothrepo/project/testhand/testimg/testfd/';
global_fd = test_rotation(1, count, filename);
% close all
filename = '/Users/saikat/Documents/UIUC/fall2015/MLSP/choothrepo/project/testhand/testimg/testfd/test_1/';
global_fd_test = test_rotation(1, count, filename);


%%%%%%%%%%%check accuracy using confusion matrix
error = zeros(count, count);
for i = 1:count
    test_cur = global_fd_test(i,:);
    for j = 1:count
        curr = global_fd(j,:);
        sum = 0;
        for k = 1:length(global_fd)
            sum = sum + (test_cur(k) - curr(k))^2;
        end
        error(i,j) = sqrt(sum);
    end
end
classfier_op = zeros(count,1);
match = 0;
for i = 1:count
    minval = 9999;
    minindex = -1;
    for j = 1:count
        if minval > error(i,j)
            minval = error(i,j);
            minindex = j;
        end
    end
    classfier_op(i,1) = minindex;
    if minindex == i
        match = match + 1;
    end
end
accuracy = match * 100 /(count)
