function svm_slack()
clearvars
numDataA = 100;
numDataB = 100;
numData = numDataA + numDataB;
numDim = 2;
C = 10;
X = [randn(numDataA, numDim) + 1;randn(numDataB, numDim)+ 3];
Y = [repmat(1,numDataA,1);repmat(-1,numDataA,1)];
%%%% calculate H and f matrix to minimize 1/2(x.' * H * x) + f.' * x
H = [eye(numDim) zeros(numDim, numData + 1);zeros(numData + 1, numData + 1 + numDim)];
f = C * [zeros(numDim + 1,1);ones(numData,1)];
Aeq = [];
beq = [];
%%% lower bounds and upper bounds for Weights (-inf, inf)
%%% lower bounds and upper bounds for slack variables (0, inf)
lb = [-inf * ones(numDim + 1,1);zeros(numData,1)];
ub = inf * ones(numDim + 1 + numData,1);
%%%calculate A matrix such that Ax <= b
A = zeros(numData, 2);
A(:,1) = Y .* X(:,1);
A(:,2) = Y .* X(:,2);
A = [-A -Y -eye(numData)];
b = -ones(numData,1);

op = quadprog(H,f,A,b,Aeq,beq,lb,ub);

la = 1, lb = 1;
for i = 1 : numData
    if (Y(i) == -1)
        classA(:,la) = X(i,:);
        la = la + 1;
    else
        classB(:,lb) = X(i,:);
        lb = lb + 1;
    end
end

classA = classA.';
classB = classB.';
figure,
plot(classA(:,1), classA(:,2), 'or')
hold on
plot(classB(:,1), classB(:,2), 'ob')

W = [op(1);op(2)];
w0 = op(3);

x1 = min(X(:,1)): max(X(:,1));
%%%%%%%%%plot the hyper plane W1*X1 + W2*X2 + w0 = 0
x2 = (- W(1) * x1 - w0 ) / W(2);
plot(x1,x2)
%%%%%%%%%plot the margins W1*X1 + W2*X2 + w0 = +/-1
%%%%%%%%upper margin
x3 = (1 - W(1) * x1 - w0) / W(2);
plot(x1,x3, '-.b');
%%%%%%%%lower margin
x4 = (-1 - W(1) * x1 - w0) / W(2);
plot(x1,x4, '-.r');

% calculate distance of each point from discriminant hyperplane
distance_vector = zeros(numData,1);
for i =1:numData
    distance_vector(i,1) = (W.' * X(i,:).' + w0) / norm(W);
end
figure, bar(distance_vector, 'r')
end
