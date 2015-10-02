function [w,h] = mynmf(x, dim, iter, err)
    [row, col] = size(x);
    W = rand(row, dim) + 10;
    [row_w, col_w] = size(W);
    H = rand(dim, col) + 10;
    [row_h, col_h] = size(H);
    error_sqr_wh_vec = zeros(1,1);
    count = 0;
    rms_wh = 1000;
    while rms_wh > err && count < iter
        wh = W * H + eps;
        count = count + 1;
        for i = 1 : row_w
            for j = 1:col_w
                cur = W(i,j);
                sum  = 0;
                for k = 1 : col
                    sum = sum + (x(i,k) / wh(i,k)) * H(j,k);
                end
                W(i,j) = cur * sum;
            end
        end
        %%%%%%%%%%%%%%%%% update H
        for j = 1 : row_h
            for k = 1:col_h
                sum = 0;
                for i = 1:row
                    sum = sum + (W(i,j) * (x(i,k) / wh(i,k)));
                end
                H(j,k) = H(j,k) * sum;
            end
        end
        %%%%%%%%%%%%try normalize%%%%%%%%%%%%%%%%%%
        for i = 1: col_w
            max_val = max(W(:,i));
            W(:,i) = W(:,i) ./ max_val;
        end
        for i = 1: row_h
            max_val = max(H(i,:));
            H(i,:) = H(i,:) ./ max_val;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        wh_old = wh;
        wh = W*H;
        rms_wh = myrms(wh_old, wh)
        error_sqr_wh_vec = [error_sqr_wh_vec rms_wh];
    end
    count
    w = W;
    h = H;
    figure
    plot(error_sqr_wh_vec)
    title('error plot vs iterations')
end