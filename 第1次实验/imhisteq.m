% 实现灰度图像的直方图均衡化算法
% 测试代码：
% F  = imread(ImPath);
% [G]=imhisteq(F);
% figure,imshow(F);
% figure,imshow(G);


function [G] = imhisteq(F)
[m,n,c] = size(F);  
if(c>1)
    F = rgb2gray(F);  
end
 
h = imhist(F,256)'; 
F = double(F);
hs = h/(m*n);     
hp0 = cumsum(hs) ;    
hp1 = round(hp0*255);       
hp1(1) = 0;    
for i=1:m
    for j=1:n 
        G(i,j) = hp1( F(i,j)+1 );
    end
end
G = uint8(G);
end

