function l3_39()
input = '39.wav';
windowSize = 512;
order = 20;
[output, samples, sampleRate] =  my_spectograph(input, windowSize);

filter = fir1(order, 0.8, 'high');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);

FigHandle = figure;
  set(FigHandle, 'Position', [50, 50, 2000, 1000]);

filter = fir1(order, 0.9, 'low');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,1)
imagesc(imcomplement(output)),colormap gray
view(0,90);axis xy; axis tight;
title('lowpass');

filter = fir1(order, [0.2 0.8], 'bandpass');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,3)
imagesc(imcomplement(output)),colormap gray
view(0,90);axis xy; axis tight;
title('bandpass');



filter = fir1(order, 0.8, 'high');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,2)
imagesc(imcomplement(output)),colormap gray;
view(0,90);axis xy; axis tight;
title('high');


filter = fir1(order, [0.20 0.4], 'stop');
samplesFiltered = conv(filter, samples);
size(samplesFiltered);
output = my_specHelper(samplesFiltered, sampleRate, windowSize);
subplot(2,2,4)
imagesc(imcomplement(output)),colormap gray
view(0,90);axis xy; axis tight;
title('band reject');

end

