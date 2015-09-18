function [output] = noise(x,ratio)
output = zeros(x);
scale = 0.02;
xx = (x+1)/2;
index = 2;
for i = 1:xx
    k = 0;
    index = 0;
    for j = 1:xx
        if (i==1 || i==x || j==1 || j==x)
            continue;
        else
            if (j<=4 && i<=4)
                output(i,j) = (ratio+i+k) * scale / 3500;
            else  
            end
        end
        k = k+10;
    end
end
topright = output*gen2(x,1);
tophalf = output + topright ;
bottomhalf = flipud(tophalf);
output = tophalf + bottomhalf;
end