% 实现线性对比度展宽
% 测试代码：
%   fa = 5;fb = 30;
%  	ga = 80;gb = 100;
%   ImPath='.\im\pict1.png';
%   J=ContrastWidening(ImPath,fa,fb,ga,gb);
%   figure,imshow(ImPath);
%   figure,imshow(J);


function [G]=ContrastWidening(ImPath,fa,fb,ga,gb)
F = imread(ImPath);
[m,n,c] = size(F); 
if c>1
F = rgb2gray(F); 
end
G = zeros(m,n); 
for i = 1 : m
    for j = 1 : n
        if(F(i,j) < fa)
            G(i,j) = (ga/fa)*F(i,j);
        elseif( F(i,j) < fb)
            G(i,j) = ((gb-ga)/(fb-fa))*(F(i,j)-fa)+ga;
        else
            G(i,j) = ((255-gb)/(255-fb))*(F(i,j)-fb)+gb;
        end
    end
end
G = uint8(G);
end

