function output = gen3(s, v)
output = zeros(s);
for i = 1:s
    for j = 1:s
        if (i==j)
            output(i,j) = v;
        end
    end
end
output;
end