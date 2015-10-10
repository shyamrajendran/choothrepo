clearvars
numDataA = 100;
numDataB = 100;
numData = numDataA + numDataB;
numDim = 2;
%%%%%%%%%%%
%%%%%Generate values from a normal distribution with mean 'x'
%%%%%and standard deviation 'y'.
%%%%%r = x + y.*randn(100,1);
X = [randn(numDataA, numDim);randn(numDataB, numDim)+ 6];
Y = [repmat(1,numDataA,1);repmat(-1,numDataA,1)];
mysvm(X,Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%overlapping data
% %%%%%%%%not working
% numDataA = 100;
% numDataB = 100;
% numData = numDataA + numDataB;
% numDim = 2;
% X = [randn(numDataA, numDim) + 1;randn(numDataB, numDim)+ 4];
% Y = [repmat(1,numDataA,1);repmat(-1,numDataA,1)];
% mysvm(X,Y);
