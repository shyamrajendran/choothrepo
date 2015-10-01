function rectangularData()

x0=-3; y0=-1;
w=6; h=2;

n=400; %number of random numbers to generate

x = x0+w.*rand(n,1);
y = y0+h.*rand(n,1);
rot = [[cos(-pi/6);sin(-pi/6)] [-sin(-pi/6); cos(-pi/6)]];
%x = x *2;
%y = y * 2;
data = [x y];
data = data * rot;

[U, S, V] = svd(cov(data));

figure
subplot(1,2,1);
plot(data(:,1), data(:,2), '.');
axis([-5 5 -5 5]);
hold on
plot(U(:,1),'g');
hold on
plot(U(:,2),'r');

Z = U * data.';
subplot(1,2,2);
plot(Z(1,:), Z(2,:), '.');
axis([-5 5 -5 5]);

end

