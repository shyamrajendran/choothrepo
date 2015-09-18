function [S, T, F] = myspectrogram(x, fs, w)

dt = 1/fs;
windowlength = w;
n= ceil(length(x)/w);
rem = n * w - length(x);
x = x.';

for i = 1 : rem
    x = [x, 0];
end

S = zeros(w/2,n);
k = 1;

%dft_mat = dft_matrix(windowlength);
for jj = 1:n
    y = x(k:k+windowlength-1);
    %ydft = fft(y.' .* hamming(w));
    ydft = fft(y.');
    %ydft =  dft_mat * y.';
    S(:,jj) = log10(abs(ydft(1:w/2)) + 1);
    k = k+windowlength;
end

T = 0 : (w*dt) : (length(x)*dt) - w*dt;
F = 0 : fs/2;

end

