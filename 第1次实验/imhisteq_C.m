% 实现彩色图像的直方图均衡化算法（算法流程可以参考灰度图像的直方图均衡化算法）。
% 参考处理图像： f11.jpg、f13.jpg
% 测试代码：
% F=imread('.\im\f11.jpg');
% [G] = imhisteq_C(F);
% figure,imshow(F);figure,imshow(G);



function [G] = imhisteq_C(F)
[m,n,c] = size(F);  
for k = 1 : c
    J = F(:,:,k);
    h = imhist(J,256)';  
    J = double(J);
    hs = h/(m*n);     
    hp0 = cumsum(hs) ;      
    hp1 = round(hp0*255);      
    hp1(1) = 0;    
    for i=1:m 
        for j=1:n 
            J(i,j) = hp1( J(i,j)+1 );
        end
    end
    G(:,:,k) = J;
end
G = uint8(G);
end
