function lec9_32()

dataPoints = 200;
data = randn(dataPoints, 2);
data(101 : 200, :) = data(101 : 200, :) + 2;
labels = ones(200,1);
labels(101 : 200) = labels(101 : 200) * -1;

class1 = zeros(2,dataPoints/2);
class2 = zeros(2,dataPoints/2);
c1 = 1; 
c2 = 1;
for i = 1 : dataPoints
    if (labels(i) == 1)
        class1(:, c1) = data(i,:);
        c1 = c1 + 1;
    else
        class2(:, c2) = data(i,:);
        c2 = c2 + 1;
    end
end

% For class 1 data
u1x = mean(class1(1,:));
u1y = mean(class1(2,:));
u1 = [u1x ; u1y];
var1 = rms(class1);
w1 = u1 ./ var1;
b1 = -(u1.' * u1 / (2 * var1)) + log(0.5);

% For class 2 data
u2x = mean(class2(1,:));
u2y = mean(class2(2,:));
u2 = [u2x ; u2y];
var2 = rms(class2);
w2 = u2 ./ var2;
b2 = -(u2.' * u2 / (2 * var2)) + log(0.5);

c1 = 0; c2 = 0;
for i = 1 : size(class2,2)
    l1 = gfunc(class1(:,i),w1,b1,w2,b2);
    l2 = gfunc(class2(:,i),w1,b1,w2,b2);
    if l1 == 1
        c1 = c1 + 1;
    else
        c2 = c2 + 1;
    end
    
    if l2 == 1
        c1 = c1 + 1;
    else
        c2 = c2 + 1;
    end
    
end
c1
c2
figure,
plot(class1(1,:), class1(2,:), 'or')
hold on
plot(class2(1,:), class2(2,:), 'ob')
f = @(x1,x2) w1(1)*x1 + w1(2)*x2 - w2(1)*x1 - w2(2)*x2 + b1 - b2;
h2 = ezplot(f,[min(data(:,1)) max(data(:,1)) min(data(:,2)) max(data(:,2))]);
h2.Color = 'g';
h2.LineWidth = 1;

[testx, testy] = meshgrid(min(data(:,1)):0.05:max(data(:,1)),min(data(:,2)):0.05:max(data(:,2)));
grid_labels = zeros(size(testx));
for m = 1 : size(testx,1)
    for n = 1 : size(testx, 2)
        curx = testx(m, n);
        cury = testy(m, n);
        glabel = gfunc([curx ; cury],w1,b1,w2,b2);
        grid_labels(m,n) = glabel;
    end
end

figure,
plot(class1(1,:), class1(2,:), 'or')
hold on
plot(class2(1,:), class2(2,:), 'ob')
contour(testx, testy, grid_labels, 2, 'k');
end

