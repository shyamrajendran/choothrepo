function sum = myrms(M1, M2)
    [row col] = size(M1);
    sum = 0;
    for i = 1:row
        for j = 1:col
            sum = sum + (M1(i,j) - M2(i,j)).^2;
        end
    end
    sum  = sqrt(sum/(row * col));
end