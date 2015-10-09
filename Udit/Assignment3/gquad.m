function label = gquad(x, W1, w1, b1, W2, w2, b2)

g1 = (x.' * (W1 * x)) + (w1.' * x) + b1;
g2 = (x.' * (W2 * x)) + (w2.' * x) + b2;

if g1 > g2
    label = 1;
else
    label = 2;
end

end

