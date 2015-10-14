function g = imggradient(data)

row = size(data,1);
col = size(data,2);
g = zeros(row,col);
for i = 2 : row - 1
    for j = 2 : col - 1
        dy = data(i+1,j) - data(i-1,j);
        dx = data(i,j+1) - data(i,j-1);
        g(i,j) = sqrt((dy * dy) + (dx * dx));
    end
end

end

