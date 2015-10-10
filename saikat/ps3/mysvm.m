function mysvm(X,Y)
numData = size(X,1)
numDim = 2;
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

%%%%%%%%%%%%%% now code the H,A,f,c for quadprog
H = eye(numDim);
H = [H zeros(numDim,1);zeros(1, numDim+1)];
f = zeros(numDim + 1,1);
A = -diag(Y) * [X ones(numData,1)];
c = -ones(numData,1);

w = quadprog(H,f,A,c);


W = [w(1);w(2)];
w0 = w(3);

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