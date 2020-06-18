% 实现直角坐标系中的图像缩小
% 参考代码
% I =imread('.\im\han.jpg'); 
% im= rsz_S1 (I,0.3,0.5); 
% imshow(I);figure, imshow(im); 

function im = rsz_S1(I,kr,kc)
[m,n,c] = size(I); % 得到原始图像尺寸
m2 = round(kr*m);  % round函数：四舍五入
n2 = round(kc*n);   % 得到新图像尺寸：m2 n2
c1 = 1/kr; c2 = 1/kc;
J = zeros(m2,n2,c); % 初始化新图像矩阵J
for i=1:m2
    for j=1:n2
        % 计算新图对应原图的x,y坐标--缩小
        x = round(c1*i);
        y = round(c2*j);
        % 检查对应坐标边界条件
        if x>m
            x = m;
        end
        if y>n
            y = n;
        end
        if x<1
            x = 1;
        end
        if y<1
            y = 1;
        end
        J(i,j,:) = I(x,y,:); 
    end 
end
im = uint8(J);
end

