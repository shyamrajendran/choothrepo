function generateData()

s = [2 2];
x = randn(334,1);
y1 = normrnd(s(1).*x,5);
y2 = normrnd(s(2).*x,10);
data = [y1 y2];
plot(data(:,1), data(:,2), '.');

end

