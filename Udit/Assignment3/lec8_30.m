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

abs_output = abs(output);

low_pass_filter = fir1(order, magnitude);
finaloutput = conv(low_pass_filter, abs_output);
figure
plot(abs_output, 'b');
hold on
plot(finaloutput * 5,'r');

num_avg = 2000;
coef = ones(1,num_avg)/ num_avg;
op1 = conv(coef, abs_output);
figure
plot(abs_output, 'b');
hold on
plot(op1 * 5,'r');

end

