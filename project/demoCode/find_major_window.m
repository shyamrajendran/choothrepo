function [group] = find_major_window(alist, window_size)
i = 1;
gc = 1;
while (i < length(alist))
    i
    endi = min(i+window_size-1,length(alist)-1)
    sub_list = alist(1,i:endi)
    group(:,gc) = mode(sub_list)
    i = i + window_size;
    gc = gc + 1;
end
end