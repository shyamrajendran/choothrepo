function [output_matrix] = mydft(N)
output_matrix = zeros(N);
sqrootn = sqrt(N);
for j = 0 : N-1
    for k = 0 : N-1 
        output_matrix(j+1,k+1) = (cos(j*k*2*pi/N) + 1j*sin(j*k*2*pi/N))/ sqrootn;
    end
end
output_matrix;
end
