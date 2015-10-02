function l4_50()
f = zeros(3);
f(:) = -1/8;
f(2,2) = 1;



input = zeros(50,50);
for i = 15:35
    for j = 15:35
        input(i,j) = 1;
    end
end
FigHandle = figure;
set(FigHandle, 'Position', [50, 50, 500, 500]);
subplot(2,2,1)
imshow(input),colormap gray
title('input1');
output = conv2(f, input);
subplot(2,2,2)
imshow(output), colormap gray
title('output1');


input = ones(50,50);
for i = 15:35
    for j = 15:35
        input(i,j) = 0;
    end
end
subplot(2,2,3)
imshow(input),colormap gray
title('input2');
output = conv2(f, input);
subplot(2,2,4)
imshow(output),colormap gray
title('output2');

end