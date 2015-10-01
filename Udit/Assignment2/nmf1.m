function nmf1()

in = zeros(100,200);
for i = 2:23
    for j = 2:23
        in(i,j) = 1;
    end
end
 
for i = 2:23
    for j = 50:90
        in(i,j) = 1;
    end
end
 
for i = 2:23
    for j = 130:160
        in(i,j) = 1;
    end
end
 
for i = 2:23
    for j = 183:200
        in(i,j) = 1;
    end
end
 
for i = 80:90
    for j = 23:50
        in(i,j) = 1;
    end
end
 
for i = 80:90
    for j = 90:130
        in(i,j) = 1;
    end
end
 
for i = 80:90
    for j = 90:130
        in(i,j) = 1;
    end
end
 
for i = 80:90
    for j = 160:183
        in(i,j) = 1;
    end
end

figure
imagesc(imcomplement(in)),colormap gray
axis xy
%nmf(in, 2);

end

