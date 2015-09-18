function I = gen(s, v)
I = zeros(s);
i = uint8(s/2);
for m = 1:s
    for n = 1:s
        if (n~=i) 
           continue;
        else
%             if (i==s)
%                 I(m,1) = 1;
%             end    
            I(m,n) = v;
        end     
    end
    i = i+1;
    if (i>s) 
        i=1;
    end
end
        