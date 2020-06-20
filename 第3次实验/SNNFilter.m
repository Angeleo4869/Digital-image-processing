function [im_filered] = SNNFilter(im_noise,n)
[h,l,c] = size(im_noise);
Y = zeros(h,l);
for i= n+1 : h-n
    for j=n+1 : l-n
        temp = [];
        for row = i-n:i+n
            for col = j-n:j+n
                a0 = double(im_noise(i,j));
                a1 = double(im_noise(row,col));
                a2 = double(im_noise(2*i-row,2*j-col));
                if (abs(a1-a0)>abs(a2-a0))
                    select_a = a2;
                else
                    select_a = a1;
                end
                
                if~(row ==i && col == j)
                    temp = [temp,select_a];
                end
            end
        end
        
        Y(i,j) = mean(temp);
    end
   
end
im_filered = uint8(Y);
end