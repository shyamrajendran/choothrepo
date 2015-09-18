function lec3_18()

[x, fs] = audioread('18.wav');

window = 64;
[S, T, F] = myspectrogram(x, fs, window);
figure('name',strcat('Spectogram : Window Size - ', int2str(window)),'numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

window = 512;
[S, T, F] = myspectrogram(x, fs, window);
figure('name',strcat('Spectogram : Window Size - ', int2str(window)),'numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

window = 2048;
[S, T, F] = myspectrogram(x, fs, window);
figure('name',strcat('Spectogram : Window Size - ', int2str(window)),'numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

end

