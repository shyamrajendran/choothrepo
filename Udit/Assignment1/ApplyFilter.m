function [K] = ApplyFilter(img,filter)

r = conv2(double(img(:,:,1)), double(filter));
g = conv2(double(img(:,:,2)), double(filter));
b = conv2(double(img(:,:,3)), double(filter));

K = cat(3, uint8(r), uint8(g), uint8(b));

end

