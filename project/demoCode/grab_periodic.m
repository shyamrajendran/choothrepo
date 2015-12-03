function [sub_list] = grab_periodic(alist, window_size,index)
i = 1;
ind = 1;
len = length(alist);
sub_list = cell(len,1);
while (i < len) 
    if (index == 0) 
        sub_list{ind} = num2str(alist(i));
        i = i + window_size;
    else
        i = i + window_size;
        sub_list{ind} = num2str(alist(min(i,len)));
        
    end    
    ind = ind + 1;
end
%sub_list
end