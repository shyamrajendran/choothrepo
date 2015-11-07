clearvars
fd_sai = load('fd_sai_hand.mat');
fd_sam = load('fd_sam_hand.mat');
fd_sai_sam = [fd_sai.global_samples_fd fd_sam.global_samples_fd];

Y_sai_target = load('Y_sai_hand.mat');
Y_sam_target = load('Y_sam_hand.mat');
Y_sai_sam = [Y_sai_target.Y Y_sam_target.Y];

N = size(fd_sai_sam,2);
total_val = sum(fd_sai_sam, 2);
mean_val = total_val ./ N;

fd_zero_mean = fd_sai_sam;
for i = 1:N
    fd_zero_mean(:,i) = fd_zero_mean(:,i) - mean_val;
end

cov_X = cov(fd_zero_mean.');
[U,S,V] = svd(cov_X);

Z = U(:,1:2).' * fd_zero_mean;
figure, scatter(Z(1,:),Z(2,:))

% Y_class = [];
% for class = 0:0
%     ind = find(Y_sai_sam(class+1,:)>0);
%     curr = Z(:,ind);
% end

ind = find(Y_sai_sam(1,:)>0);
Y_0 = Z(:,ind);
ind = find(Y_sai_sam(2,:)>0);
Y_1 = Z(:,ind);
ind = find(Y_sai_sam(3,:)>0);
Y_2 = Z(:,ind);
ind = find(Y_sai_sam(4,:)>0);
Y_3 = Z(:,ind);
ind = find(Y_sai_sam(5,:)>0);
Y_4 = Z(:,ind);
ind = find(Y_sai_sam(6,:)>0);
Y_5 = Z(:,ind);
ind = find(Y_sai_sam(7,:)>0);
Y_6 = Z(:,ind);
ind = find(Y_sai_sam(8,:)>0);
Y_7 = Z(:,ind);
ind = find(Y_sai_sam(9,:)>0);
Y_8 = Z(:,ind);
ind = find(Y_sai_sam(10,:)>0);
Y_9 = Z(:,ind);
ind = find(Y_sai_sam(11,:)>0);
Y_10 = Z(:,ind);

figure,
scatter(Y_0(1,:),Y_0(2,:), 'r')
hold on
scatter(Y_1(1,:),Y_1(2,:), 'g')
hold on
scatter(Y_2(1,:),Y_2(2,:), 'b')
hold on
scatter(Y_3(1,:),Y_3(2,:), 'y')
hold on
scatter(Y_4(1,:),Y_4(2,:), 'm')
hold on
scatter(Y_5(1,:),Y_5(2,:), 'c')
hold on
scatter(Y_6(1,:),Y_6(2,:), 'w')
hold on
scatter(Y_7(1,:),Y_7(2,:), 'k')
hold on
% scatter(Y_8(1,:),Y_8(2,:), 'r+')
% hold on
% plot(Y_9(1,:),Y_9(2,:), 'r-')
% hold on
% scatter(Y_10(1,:),Y_10(2,:), 'r*')
% hold on
