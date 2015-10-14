%%
%%%%%%%%%%slide 9, 32
clearvars
numDataA = 100;
numDataB = 100;
numData = numDataA + numDataB;
numDim = 2;
%%%%%%%%%%%
%%%%%Generate values from a normal distribution with mean 'x'
%%%%%and standard deviation 'y'.
%%%%%r = x + y.*randn(100,1);
dataA = randn(numDataB, numDim);
dataB = randn(numDataB, numDim)+ 2;
X = [dataA;dataB];
figure,
scatter(dataA(:,1),dataA(:,2), 'or');
hold on
scatter(dataB(:,1),dataB(:,2), 'ob');

classA = dataA.';
classB = dataB.';
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

[x1_test, x2_test] = meshgrid(min(X(:,1)):0.05:max(X(:,1)),min(X(:,2)):0.05:max(X(:,2)));
classfier_op = zeros(size(x1_test));
for j = 1: length(x1_test(:))
    test_data = [x1_test(j);x2_test(j)];
    a = W_classA.' * test_data + b_classA;
    b = W_classB.' * test_data + b_classB;
    if (a > b)
        classfier_op(j) = 1;
    else
        classfier_op(j) = -1;
    end
end
contour(x1_test, x2_test, classfier_op, 2, 'k');

%%
%%%%%%%%% lecture 9slide 33,34
clearvars
for count = 1:3
    numDataA = 100;
    numDataB = 100;
    numData = numDataA + numDataB;
    numDim = 2;
    theta = 130;
    if count == 3
        %%%%data for lecture 9 slide 34 part B
        dataB = 7 *randn(numDataA,2);
        dataA = randn(numDataA,2) + 3;
    else
        %%%%data for lecture 9 slide 33, 34 part A
        y1 = 4 * randn(numDataA,1);
        y2 = 0.5 * randn(numDataA,1);
        rotation = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
        Y = [y1 y2] * rotation;
        y1 = Y(:,1);
        y2 = Y(:,2);
        dataA = [y1 y2];
        mean_offset = 0;
        if count == 1
            mean_offset = 7;
        else
            mean_offset = 3;
        end
        dataB = randn(numDataB,2) + mean_offset;
        X = [dataA;dataB];
    end
    figure,
    scatter(dataA(:,1),dataA(:,2), 'or');
    hold on
    scatter(dataB(:,1),dataB(:,2), 'ob');
    classA = dataA.';
    classB = dataB.';


    mean_classA_x = mean(classA(1,:));
    mean_classA_y = mean(classA(2,:));
    mean_classA = [mean_classA_x ; mean_classA_y];
    covA = cov(classA.');
    invcovA = inv(covA);
    WA = invcovA .* (-0.5);
    wA = invcovA * mean_classA;
    bA = ((mean_classA.' * wA).*(-0.5)) - (0.5 * log(det(covA))) + log(0.5);


    mean_classB_x = mean(classB(1,:));
    mean_classB_y = mean(classB(2,:));
    mean_classB = [mean_classB_x ; mean_classB_y];
    covB = cov(classB.');
    invcovB = inv(covB);
    WB = invcovB .* (-0.5);
    wB = invcovB * mean_classB;
    bB = ((mean_classB.' * wB).*(-0.5)) - (0.5 * log(det(covB))) + log(0.5);

    [x1_test, x2_test] = meshgrid(min(X(:,1)):0.1:max(X(:,1)),min(X(:,2)):0.1:max(X(:,2)));
    classfier_op = zeros(size(x1_test));
    for j = 1: length(x1_test(:))
        test_data = [x1_test(j);x2_test(j)];
        a = test_data.' * WA * test_data + wA.' * test_data + bA;
        b = test_data.' * WB * test_data + wB.' * test_data + bB;
        if (a > b)
            classfier_op(j) = 1;
        else
            classfier_op(j) = -1;
        end
    end
    contour(x1_test, x2_test, classfier_op, 2, 'k');
end
%%
clearvars
load('face2.mat')
%%%%%%calculate average face
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
mean_classA_x = mean(classA(1,:));
mean_classA_y = mean(classA(2,:));
mean_classA = [mean_classA_x ; mean_classA_y];
covA = cov(classA.');
invcovA = inv(covA);
WA = invcovA .* (-0.5);
wA = invcovA * mean_classA;
bA = ((mean_classA.' * wA).*(-0.5)) - (0.5 * log(det(covA))) + log(0.5);


mean_classB_x = mean(classB(1,:));
mean_classB_y = mean(classB(2,:));
mean_classB = [mean_classB_x ; mean_classB_y];
covB = cov(classB.');
invcovB = inv(covB);
WB = invcovB .* (-0.5);
wB = invcovB * mean_classB;
bB = ((mean_classB.' * wB).*(-0.5)) - (0.5 * log(det(covB))) + log(0.5);
%%%%%%calculate gi's
correct = 0;
for i=1:length(classA)
    a = classA(:,i).' * WA * classA(:,i) + wA.' * classA(:,i) + bA;
    b = classA(:,i).' * WB * classA(:,i) + wB.' * classA(:,i) + bB;
    if (a > b)
        correct = correct + 1;
    end
end

correct
correct = 0;
for i=1:length(classB)
    a = classB(:,i).' * WA * classB(:,i) + wA.' * classB(:,i) + bA;
    b = classB(:,i).' * WB * classB(:,i) + wB.' * classB(:,i) + bB;
    if (b > a)
        correct = correct + 1;
    end
end
correct

figure, scatter(classA(1,:),classA(2,:), 'r')
hold on
scatter(classB(1,:),classB(2,:), 'b')
f = @(x1,x2) bA + wA(1)*x1 + wA(2)*x2 + WA(1,1)*x1.^2 + ...
    (WA(1,2)+WA(2,1))*x1.*x2 + WA(2,2)*x2.^2 - ...
    (bB + wB(1)*x1 + wB(2)*x2 + WB(1,1)*x1.^2 + ...
    (WB(1,2)+WB(2,1))*x1.*x2 + WB(2,2)*x2.^2);
h3 = ezplot(f,[min(Z(1,:)) max(Z(1,:)) min(Z(2,:)) max(Z(2,:))]);
h3.Color = 'k';
h3.LineWidth = 1;

