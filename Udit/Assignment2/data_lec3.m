function data_lec3()

y1 = 4 * randn(500,1);
y2 = 1 * randn(500,1);
R = [cosd(135) -sind(135); sind(135) cosd(135)];
G = [y1, y2] * R;
y1 = G(:,1);
y2 = G(:,2);

data = [y1 y2];

[U, S, V] = svd(cov(data));

figure
subplot(1,2,1);
plot(data(:,1), data(:,2), 'o');
hold on
plot(U(:,1),'g');
hold on
plot(U(:,2),'r');

Z = U * data.';
subplot(1,2,2);
plot(Z(1,:), Z(2,:), 'o');

end

