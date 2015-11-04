function fd = fourierDescriptors(ed)

[xk yk] = find(ed > 0);    

sk = complex(xk, yk);
    

avg = sum(sk) ./ length(sk);
tk = sk - avg;

anglek = angle(tk);
[a b] = sort(anglek);

for i = 1 : length(anglek)
    st(i) = sk(b(i));
end

fdesc = fft(st);

nfdesc = fdesc;
nfdesc(1) = 0;
si1 = abs(fdesc(2));
nfdesc = nfdesc / si1;
nfdesc = abs(nfdesc);
fd = nfdesc;

end

