function [conv] = converge(old, new, errorrate) 
error1 = sqrt(mean(old(:).^2));
error2 = sqrt(mean(new(:).^2));
e = abs(error1-error2);
if (abs(e) <= errorrate) 
    conv = 1;
else
    conv = 0;
end
end