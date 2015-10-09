function lec8_30()

order = 2000;
%magnitude = 0.000005;
magnitude = 0.00000000005;
[x, fx] = audioread('pa.wav');
[y, fy] = audioread('shot.wav');

flippedy = y(size(y, 1) : -1 : 1);
output = conv(flippedy, x);
figure
plot(output);

output = abs(output);
figure
plot(output);

low_pass_filter = fir1(order, magnitude);
output = conv(low_pass_filter, output);
figure
plot(output);

end

