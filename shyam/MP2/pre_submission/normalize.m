function [op] =  normalize(A) 
% op = normc(in);
% op =  (A - min2(A))/(max2(A) - min2(A));
op = A/max(abs(A(:)));
end