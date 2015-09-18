function lec3_filter1()

filter1 = zeros(25);
factor = 100;

k = 1;
for j = 13 : -1 : 4
    filter1(j,13) = k / factor;
    
    for i = 14 : 21
        filter1(j, i) = (1 - ((i-13)*0.1)) * k / factor;
    end

    for i = 4 : 12
        filter1(j, i) = (1 - ((13-i)*0.1)) * k / factor;
    end
    
    k = k - 0.1;
end

filter12 = rot90(rot90(filter1));
filter12 = filter12((14 : 25), :);

filter1((14:25), :) = filter12; 
figure
colormap gray
imagesc(filter1);

ApplyFilter(filter1);
end

