function label = gfunc(x, w1, b1, w2, b2)

g1 = (w1.' * x) + b1;
g2 = (w2.' * x) + b2;

if g1 > g2
    label = 1;
else
    label = 2;
end

end

