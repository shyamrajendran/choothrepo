function [output] = blur(n)
k = 1;
output = zeros(n);
factor = 100;
for j = 13 : -1 : 4
    output(j,13) = k / factor;
    for i = 14 : 22
        output(j, i) = (1 - ((i-13)*0.1)) * k / factor;
    end
    for i = 4 : 13
        output(j, i) = (1 - ((13-i)*0.1)) * k / factor;
    end
    k = k - 0.1;
end
outputMap = rot90(rot90(output));
outputMap = outputMap((14 : 24), :);
output((14:24), :) = outputMap; 
output;
imagesc(output);
end

