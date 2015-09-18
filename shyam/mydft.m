function [output] = mydft(n) 
output = zeros(n);
sqrtn = sqrt(n);
v = 2*pi/n;
for j = 0:n-1
    for k = 0:n-1
        output(j+1,k+1) = (cos((j+1)*(k+1)*v) +1j*sin((j+1)*(k+1)*v))/sqrtn;
    end
end
end
