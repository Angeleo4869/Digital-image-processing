function [im_filered] = KNN_denoise (I,K,N)
[h,l,c] = size(I);
Y = zeros(h,l);
n = floor(N/2);
im = double(I);
mid = floor((N*N)/2 )+1;
for i = n+1 : h-n;
    for j = n+1 : l-n
        block = im(i-n : i+n, j-n : j+n );
        blockdelt = abs(block-im(i,j));
        block_delt_inline = blockdelt(:);
        block_delt_inline(mid) = [];
        [tempSot,Ind] = sort(block_delt_inline);
        block_inline = block(:);
        block_inline(mid) = [];
        KNNS = block_inline(Ind(1:K));
        Y(i,j) = mean(KNNS);
    end
end
im_filered=uint8(Y);
end
