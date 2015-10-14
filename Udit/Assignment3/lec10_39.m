function lec10_39()

dataPoints = 200;
data = randn(dataPoints, 2);
data(101 : 200, :) = data(101 : 200, :) + 1;
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

class1 = class1.';
class2 = class2.';
figure,
plot(class1(:,1), class1(:,2), 'or')
hold on
plot(class2(:,1), class2(:,2), 'ob')

%H = eye(3); 
H = eye(2);
H = [H zeros(2,1);zeros(1, 3)];
%f = zeros(numDim + 1,1);
%f = [1e-06;1e-06;0];
C = 10e10;
f = [C * ones(1, 2), 0]';
A = (-1 .* diag(labels)) * [data ones(dataPoints,1)];
b = -1 .* ones(dataPoints,1);
result = quadprog(H,f,A,b,A,b);
w = [result(1);result(2)];
w0 = result(3);

%%%Decision Boundary
x1 = min(data(:,1)): max(data(:,1));
x2 = (- w(1) * x1 - w0 ) / w(2);
plot(x1, x2)

x2 = (1 - w(1) * x1 - w0) / w(2);
plot(x1, x2, '-.r');

x2 = (-1 - w(1) * x1 - w0) / w(2);
plot(x1, x2, '-.b');

% calculate distance of each point from discriminant hyperplane
distances = zeros(dataPoints,1);
for i =1:dataPoints
    distances(i,1) = (w.' * data(i,:).' + w0) / norm(w, 2);
end
figure, stem(distances, 'b')

end

