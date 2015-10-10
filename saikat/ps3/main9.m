clearvars
load('face2.mat')
%%%%%%calculate average face
mean_face = zeros(780,1);
mean_face = sum(XX,2);
mean_face = mean_face / 400;
figure, colormap gray, imagesc(reshape(mean_face(:,1), 30,26));

for i = 1: 400
    XX(:,i) = XX(:,i) - mean_face;
end
%%%%%%%%%%%%%
[U,S,V] = svd(cov(XX.'));
W = U(:,1:2).';
Z = W * XX;

% classA, classB
la = 1, lb = 1;
labels = zeros(400,1);
for i = 1 : 400
    if (g(i) == 0)
        classA(:,la) = Z(:,i);
        la = la + 1;
        labels(i,1) = 1;
    else
        classB(:,lb) = Z(:,i);
        lb = lb + 1;
    end
end

figure, scatter(classA(1,:),classA(2,:), 'r')
hold on
scatter(classB(1,:),classB(2,:), 'b')

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Linear Discriminant calculation
mean_x_classA = mean(classA(1,:));
mean_y_classA = mean(classA(2,:));
mean_classA = [mean_x_classA ; mean_y_classA];
varClassA = 0;
for i = 1:length(classA)
    varClassA =  varClassA + (classA(1,i) - mean_classA(1)).^2 + (classA(2,i) - mean_classA(2)).^2;
end
varClassA = varClassA / length(classA);

mean_x_classB = mean(classB(1,:));
mean_y_classB = mean(classB(2,:));
mean_classB = [mean_x_classB ;mean_y_classB];

varClassB = 0;
for i = 1:length(classB)
    varClassB =  varClassB + (classB(1,i) - mean_classB(1)).^2 + (classB(2,i) - mean_classB(2)).^2;
end
varClassB = varClassB / length(classB);

W_classA = mean_classA ./ varClassA;
W_classB = mean_classB ./ varClassB;
b_classA = (-1 * (mean_classA.' * mean_classA) /  (2* varClassA)) + log(0.5);
b_classB = (-1 * (mean_classB.' * mean_classB) /  (2* varClassB)) + log(0.5);


%%%%%%%%%test with training data
correct = 0;
for i=1:length(classA)
    a = W_classA.' * classA(:,i) + b_classA;
    b = W_classB.' * classA(:,i) + b_classB;
    if (a > b)
        correct = correct + 1;
    end
end

correct = 0;
for i=1:length(classB)
    a = W_classA.' * classB(:,i) + b_classA;
    b = W_classB.' * classB(:,i) + b_classB;
    if (b > a)
        correct = correct + 1;
    end
end

%%%%%%%%%%plot the decision boundary
f = @(x1,x2) W_classA(1)*x1 + W_classA(2)*x2 - W_classB(1)*x1 - W_classB(2)*x2 + b_classA - b_classB;
h2 = ezplot(f,[min(Z(1,:)) max(Z(1,:)) min(Z(2,:)) max(Z(2,:))]);
h2.Color = 'b';
h2.LineWidth = 1;

%%%%%%%%%%%%%%%%%%QDA%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% quadratic boundaries
covA = cov(classA.');
inv_covA = inv(covA);
W_mat_A = -0.5 .* inv_covA;
W_vec_A = inv_covA * mean_classA;
W_scalar_A = (-0.5 .* mean_classA.' * inv_covA * mean_classA) - (0.5 * log(det(covA))) + log(0.5);

covB = cov(classB.');
inv_covB = inv(covB);
W_mat_B = -0.5 .* inv_covB;
W_vec_B = inv_covB * mean_classB;
W_scalar_B = (-0.5 .* mean_classB.' * inv_covB * mean_classB) - (0.5 * log(det(covB))) + log(0.5);

%%%%%%calculate gi's
correct = 0;
for i=1:length(classA)
    a = classA(:,i).' * W_mat_A * classA(:,i) + W_vec_A.' * classA(:,i) + W_scalar_A;
    b = classA(:,i).' * W_mat_B * classA(:,i) + W_vec_B.' * classA(:,i) + W_scalar_B;
    if (a > b)
        correct = correct + 1;
    end
end

correct
correct = 0;
for i=1:length(classB)
    a = classB(:,i).' * W_mat_A * classB(:,i) + W_vec_A.' * classB(:,i) + W_scalar_A;
    b = classB(:,i).' * W_mat_B * classB(:,i) + W_vec_B.' * classB(:,i) + W_scalar_B;
    if (b > a)
        correct = correct + 1;
    end
end
correct

figure, scatter(classA(1,:),classA(2,:), 'r')
hold on
scatter(classB(1,:),classB(2,:), 'b')
f = @(x1,x2) W_scalar_A + W_vec_A(1)*x1 + W_vec_A(2)*x2 + W_mat_A(1,1)*x1.^2 + ...
    (W_mat_A(1,2)+W_mat_A(2,1))*x1.*x2 + W_mat_A(2,2)*x2.^2 - ...
    (W_scalar_B + W_vec_B(1)*x1 + W_vec_B(2)*x2 + W_mat_B(1,1)*x1.^2 + ...
    (W_mat_B(1,2)+W_mat_B(2,1))*x1.*x2 + W_mat_B(2,2)*x2.^2);
h3 = ezplot(f,[min(Z(1,:)) max(Z(1,:)) min(Z(2,:)) max(Z(2,:))]);
h3.Color = 'k';
h3.LineWidth = 1;

