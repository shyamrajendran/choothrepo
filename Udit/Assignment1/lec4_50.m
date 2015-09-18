function lec4_50()

input = zeros(100,100);

filter = zeros(3);
filter(:) = -1/8;
filter(2,2) = 1;

for i = 30 : 70
    for j = 30 : 70
        input(i,j) = 1;
    end
end


final = conv2(input,filter);
figure('name','Lecture 4 Slide 50','numbertitle','off')
subplot(2,2,1);
imshow(input);
subplot(2,2,2);
imshow(final);

input = ones(100,100);

filter = zeros(3);
filter(:) = -1/8;
filter(2,2) = 1;

for i = 30 : 70
    for j = 30 : 70
        input(i,j) = 0;
    end
end


final = conv2(input,filter, 'valid');
subplot(2,2,3);
imshow(input);
subplot(2,2,4);
imshow(final);

end

