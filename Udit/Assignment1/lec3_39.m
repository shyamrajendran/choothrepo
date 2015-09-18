function lec3_39()

[x, fs] = audioread('39.wav');
window = 512;
[S, T, F] = myspectrogram(x,fs,window);
figure('name','Actual Signal Spectogram','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

order = 50;

low_pass_filter = fir1(order, 0.1);
img = conv(x,low_pass_filter);

[S, T, F] = myspectrogram(img,fs,window);
figure('name','Low pass filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

high_pass_filter = fir1(order, 0.4, 'high');
img = conv(x,high_pass_filter);
[S, T, F] = myspectrogram(img,fs,window);
figure('name','High pass filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

band_pass_filter = fir1(order, [0.3 0.6]);
img = conv(x,band_pass_filter);
[S, T, F] = myspectrogram(img,fs,window);
figure('name','Band pass filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

band_reject_filter = fir1(order, [0.3 0.6],'stop');
img = conv(x,band_reject_filter);
[S, T, F] = myspectrogram(img,fs,window);
figure('name','Band reject filter','numbertitle','off')
colormap gray
imagesc(T, F, 1 - S);
axis xy; axis tight; view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');

end

