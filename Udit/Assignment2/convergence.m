function [sum] = convergence(W, Wlast)

m = size(W,1);
n = size(W,2);

sum = 0;
for i = 1 : m
    for j = 1 : n
        diff = abs(W(i,j) - Wlast(i,j));
        sum = sum + (diff * diff);
    end
end

sum = sqrt(sum / (m*n));
end

