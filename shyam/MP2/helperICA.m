function [W] = helperICA(learningRate, delta, W, X, D, N)
C = size(W*X,2);
for i = 1:N
    disp(i);
    y = W*X;
    old = W;
    fy = y.^3;
    dW = (D*C - fy*(y.')) * W/C;
    W = W + learningRate*dW;
    new = W;
    if(converge(old, new, delta))
        disp('converged');
        break;
    end    
end