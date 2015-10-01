xv = [1 5 7 3 1];
yv = [1 3 7 5 1];
figure
plot(xv,yv);

xq = randn(10000,1);
yq = randn(10000,1);
figure
in = inpolygon(xq * 3, yq * 3, xv, yv);
plot(xq(in),yq(in),'r+') 