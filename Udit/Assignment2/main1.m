function main()

%% Lecture 3 Slide 25
x = randn(500,1);
y1 = normrnd(2.*x,1);
y2 = normrnd(2.*x,1);

mx = mean(y1);
my = mean(y2);

for i = 1 : size(y1)
    y1(i) = y1(i) - mx;
end

for i = 1 : size(y2)
    y2(i) = y2(i) - my;
end

data = [y1 y2];

[U, S, V] = svd(cov(data));

figure
subplot(1,2,1);
plot(data(:,1), data(:,2), '.');
hold on
plot(U(:,1),'g');
hold on
plot(U(:,2),'r');

Z = U * data.';
subplot(1,2,2);
plot(Z(1,:), Z(2,:), '.');

%% Lecture 
end

