function [sub_list] = grab_periodic(alist, window_size,index)
i = 1;
ind = 1;
len = length(alist);
while (i < len) 
    if (index == 0) 
        sub_list(1,ind) = round(alist(i),0);
        i = i + window_size;
    else
        i = i + window_size;
        sub_list(1,ind) = round(alist(min(i,len)),0);
        
    end    
    ind = ind + 1;
end
end