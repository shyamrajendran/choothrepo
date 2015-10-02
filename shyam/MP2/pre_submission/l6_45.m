
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
    for j = 20:40
        in(i,j) = 1;
    end
end

for i = 80:90
    for j = 80:110
        in(i,j) = 1;
    end
end

for i = 80:90
    for j = 150:180
        in(i,j) = 1;
    end
end
imagesc(imcomplement(in)),colormap gray;
axis xy

%% NMF
errorrate = 1e-5;
X = double(in);
H = rand(2,200)+10;
W = rand(100, 2)+10;
N = 500;
[output,W,H,N] = nmf_helper(X,W,H,N,errorrate);
figure
subplot(4,1,1)
plot(W(:,1)),title('Sometimes need to be run due to rand initiation issue. W column 1');
subplot(4,1,2)
plot(W(:,2)),title('W column 2');
subplot(4,1,3)
plot(H(1,:)),title('H ROW 1');
subplot(4,1,4)
plot(H(2,:)),title('H ROW 2');




