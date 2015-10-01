function icaSample()

eps = 1e-100;         % Convergence criteria
maxIters = 100;     % Maximum # iterations

a = -0.5;
b = 0.5;
r1 = (b-a).*rand(1000,1) + a;
r2 = (b-a).*rand(1000,1) + a;
x = 2*r1 + r2;
y = r1 + r2;
data = [x,y];
[d n] = size(data.');

% Random initial weights
normRows = @(X) bsxfun(@times,X,1 ./ sqrt(sum(X.^2,2)));
W = normRows(rand(2,d));

% FastICA w/ Gaussian negentropy
k = 0;
err = inf;
while (err > eps) && (k < maxIters)
    % Increment counter
    k = k + 1;
    
    % Update weights
    Wlast = W; % Save last weights
    Sk = permute(Wlast * data.',[1 3 2]);
    G = Sk .* exp(-0.5 * Sk.^2);
    Gp = Sk .* G;
    W = mean(bsxfun(@times,G,permute(data.',[3 1 2])),3) + bsxfun(@times,mean(Gp,3),Wlast);
    W = normRows(W);
    
    % Decorrelate weights
    [U,S,~] = svd(W,'econ');
    W = U * diag(1 ./ diag(S)) * U' * W;
    
    % Update error
    err = max(1 - dot(W,Wlast,2));
    
    % Display progress
    %if dispFlag == true
    %    sprintf('Iteration %i: max(1 - <w%i,w%i>) = %.4g\n',k,k,k - 1,err);
    %end
end

% Transformation matrix
A = W;

% Independent components
Z = A * data.';
figure
plot(Z(1,:), Z(2,:), '.');

end

