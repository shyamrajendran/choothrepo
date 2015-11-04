function fd = fourierDescriptors1(ed)

[xk yk] = find(ed > 0);

xc = 0; 
yc = 0;

for i = 1 : size(xk, 1)
    xc = xc + xk(i);
    yc = yc + yk(i);
end

xc = xc / size(xk, 1);
yc = yc / size(yk, 1);

sk = complex(xk - xc, yk - yc);

N = 128;
d = uint8(floor(size(sk,1) / N));

pos = 1;
st = zeros(1, N);
for i = 1 : N
    st(i) = sk(pos);
    pos = pos + d;
end

fdesc = fft(st);

nfdesc = fdesc;
nfdesc(1) = 0;
si1 = abs(fdesc(2));
nfdesc = nfdesc / si1;
nfdesc = abs(nfdesc);
fd = nfdesc;

end

