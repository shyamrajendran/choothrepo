function var = rms(W)

ux = mean(W(1,:));
uy = mean(W(2,:));
sum = 0;
for i = 1 : size(W,2)
    dx = (W(1,i) - ux).^2;
    dy = (W(2,i) - uy).^2;
    sum = sum + dx + dy;
end

var = sum / size(W,2);

end

