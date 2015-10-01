function lec7_36()

load('cities.mat');
data = D;
%data = [1 2 3;4 5 6;7 8 9];
M = size(data,1);
N = size(data,2);
%M = [1 2 3;4 5 6;7 8 9];
%M1 = M;

average_col = zeros(M,1);

for i = 1 : M
    sum = 0;
    for j = 1 : N
        sum = sum + data(i,j);
    end
    average_col(i,1) = sum / N;
end


for i = 1 : N
    data(:,i) = data(:,i) - average_col;
end

average_row = zeros(1,N);
    
for i = 1 : N
    sum = 0;
    for j = 1 : M
        sum = sum + data(j,i);
    end
    average_row(1,i) = sum / M;
end

for i = 1 : M
    data(i,:) = data(i,:) - average_row;
end

[U,S,V] = svd(cov(data));
U = U(:,1:3);
Z = U.' * data;

figure
scatter3(Z(2,:),Z(3,:),Z(1,:),'ro');
for k = 1:size(Z,2)
 text(Z(2,k),Z(3,k),Z(1,k),cities{k});
end

end

