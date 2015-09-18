function l3_18()
input = '18.wav';
list = [64,512,2048];
FigHandle = figure;
  set(FigHandle, 'Position', [50, 50, 2000, 1000]);

i = 1;
for windowSize = list
    [output, samples, sampleRate] = my_spectograph(input, windowSize);
    increments = size(samples)/windowSize;
    x = 1:increments:size(samples);
    y = log(linspace(1, 6000,5));
    subplot(3,1,i);
    colormap gray,imagesc(x,y,1-output);
    view(0,90);
    axis xy; axis tight;
    xlabel('Time');
    ylabel('Frequency Hz');
    str = sprintf('Spectogram function outout for WindowSize = %d ',windowSize);
    title(str);
    i = i + 1;
end

end

