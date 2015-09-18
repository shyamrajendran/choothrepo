function lec3_49()

sampling_factor = 8;
window = 128;
[x, fs] = audioread('49.mp3');

[S, T, F] = myspectrogram(x, fs, window);
figure('name','Actual Signal Spectogram','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

y = 1 : sampling_factor : length(x);

sampled = zeros(1,length(y));

for i = 1 : length(y)
    sampled(i) = x(y(i));
end

[S, T, F] = myspectrogram(sampled.', fs/sampling_factor, window);
figure('name','Signal sampled at 1/8 (Aliasing)','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

low_pass_filter = fir1(50, 1/sampling_factor);
filteredSignal = conv(x, low_pass_filter);

y = 1 : sampling_factor : length(filteredSignal);
sampled = zeros(1,length(y));

for i = 1 : length(y)
    sampled(i) = filteredSignal(y(i));
end

[S, T, F] = myspectrogram(sampled.', fs/sampling_factor, window);
figure('name','Sampled Signal after Lowpass filter ','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

end

