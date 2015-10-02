function [output,W,H,N] = nmf_helper(X,W,H,N,errorrate)
[rW, cW] = size(W);
[rH, cH] = size(H);
for loop = 1:N
    WH = (W*H)+eps;
    old = WH;
    for i = 1:rW
        for j = 1:cW
            sum = 0;
            for k = 1:cH
                sum = sum + (X(i,k))/(WH(i,k))*H(j,k);
            end
            W(i,j) = W(i,j) * sum;
        end
    end
    
    for j = 1:rH
        for k = 1:cH
            sum = 0;
            for i = 1:rW
                sum = sum + W(i,j)*((X(i,k))/(WH(i,k)));
            end
            H(j,k) = H(j,k) * sum;
        end
    end
%     
%     converge(old,new,errorrate)
%     if (converge(old,new,errorrate) == 1)
%         break
%     end
    % trying to normalize
    for i = 1: cW
        maxv = max(W(:,i));
        W(:,i) = W(:,i) ./ maxv;
    end
    for i = 1: rH
        maxv = max(H(i,:));
        H(i,:) = H(i,:) ./ maxv;
    end    
end
output = WH;
W;
H;
end