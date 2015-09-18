function [dft_mat] = dft_matrix(N)

dft_mat = zeros(N);

for j = 0 : N-1
    for k = 0 : N-1
        val = j*k*2*pi/N;
        sq_root = sqrt(N);
        a = cos(val) / sq_root;
        b = sin(val) / sq_root;
        dft_mat(j+1,k+1) = complex(a,b);
    end
end

end

