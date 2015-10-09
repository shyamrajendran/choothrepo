function sai()

clearvars
load('one.mat')
figure,
colormap gray
imagesc(one)
[row, col] = size(one);
one_gradient = zeros(row,col);
for i = 2: (row - 1)
    for j = 2 : (col - 1)
        dy = one(i-1, j) - one(i+1, j);
        dx = one(i, j-1) - one(i, j+1);
        one_gradient(i,j) = sqrt(dy.^2 + dx.^2);
    end
end

figure,
colormap gray
imagesc(one_gradient)


op_flipped = fliplr(flipud(one_gradient));
figure, colormap gray
imagesc(op_flipped)

convop = conv2(one_gradient, op_flipped);
figure, colormap gray
imagesc(convop)

end

