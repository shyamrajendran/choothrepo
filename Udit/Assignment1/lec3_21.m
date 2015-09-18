function lec3_21()

%t= [0:0.1:6.1];
t = 2*pi*(1:32)/32;
x = zeros(size(t,2),size(t,2));
y = zeros(size(t,2),size(t,2));
for i = 1 : size(t,2)
    x(i,:) = t;
end

for i = 1 : size(t,2)
    y(:,i) = t;
end    

%F = dftmtx(size(t,2));
F = dft_matrix(size(t,2));
A = 1;

i1 = A * sin(3 * x);
i1 = abs(F * i1 * F);
figure
colormap gray
imagesc(imcomplement(i1));

i2 = A * sin(5 * y);
i2 = abs(F * i2 * F);
figure
colormap gray
imagesc(imcomplement(i2));

i3 = A * sin(3 * x + 3 * y);
i3 = abs(F * i3 * F);
figure
colormap gray
imagesc(imcomplement(i3));

i4 = A * (sin(3*x + 3*y) + sin(6*x + 8*y));
i4 = abs(F * i4 * F);
figure
colormap gray
imagesc(imcomplement(i4));

end

