function [group] = find_major_window(alist, window_size)
alist = [1,2,1,2,6,1,1,1,2,1,1,1,1,1,1,2,1,1];
window_size = 5;2
i = 1;
gc = 1;
while (i < length(alist))
    i
    endi = min(i+window_size-1,length(alist)-1)
    sub_list = alist(1,i:endi)
    group(:,gc) = mode(sub_list)
    i = i + endi;
    gc = gc + 1;
end
end