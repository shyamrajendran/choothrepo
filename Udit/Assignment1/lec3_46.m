function lec3_46()
originalRGB = imread('46.jpg');
figure, imshow(originalRGB);

%%%%% filter 1 %%%%%%
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
figure, colormap gray, imagesc(filter1);
ApplyFilter(filter1);

%%%%% filter 2 %%%%%%
filter2 = zeros(7);
filter2(4,4) = 1;
filter2(4,5) = 0.75; filter2(4,3)  = 0.75; filter2(3,4) = 0.75; filter2(5,4) = 0.75;
filter2(3,3) = 0.5; filter2(3,5)  = 0.5; filter2(5,3) = 0.5; filter2(5,5) = 0.5;
filter2(2,4) = 0.25; filter2(4,2)  = 0.25; filter2(4,6) = 0.25; filter2(6,4) = 0.25;
filter2(2,3) = 0.125; filter2(2,5) = 0.125; filter2(3,2) = 0.125; filter2(5,2) = 0.125; filter2(3,6) = 0.125; 
filter2(5,6) = 0.125; filter2(6,3) = 0.125; filter2(6,5) = 0.125;
filter2 = filter2 .* 0.2;    
figure, colormap gray, imagesc(filter2);
ApplyFilter(filter2);


%%%%% filter 3 %%%%%%
filter3 = zeros(20,40);
e = size(filter3,2);
for i = 1 : size(filter3,1)
    filter3(i,i) = 0.035;
    filter3(i,e) = 0.035;
    e = e - 1;
end
figure, colormap gray, imagesc(filter3);
ApplyFilter(filter3);

%%%%% filter 4 %%%%%%

filter4 = zeros(1,41);
filter4(1,21) = 0.8;
filter4(1,20) = -0.1;
filter4(1,22) = -0.1;
figure, colormap gray, imagesc(filter4);
ApplyFilter(filter4);

end