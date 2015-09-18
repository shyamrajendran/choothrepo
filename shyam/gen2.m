function I = gen2(s,v)
I = zeros(s);
n = s;
for m = 1:s
    I(m,n) = v;
    n = n-1;
end
I;
end
        