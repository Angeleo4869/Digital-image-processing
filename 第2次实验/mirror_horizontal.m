% 实现图像水平镜像
% 测试数据
% I  =imread('.\im\pepper1.bmp'); 
% [im]= mirror_horizontal(I);
% imshow(I);figure, imshow(im)

function [OutImage] = mirror_horizontal(InputImage)
[n,m,c] = size(InputImage);%1、得到原始图像尺寸n,m,c
OutImage = zeros(n, m, c);%2、初始化新图像矩阵G
    MirrorArray = [-1 0 n+1;0 1 0; 0 0 1];%镜像反转矩阵
    for yIndex = 1:n
        for xIndex = 1:m
            InIndex= [xIndex;yIndex;1];%定义齐次坐标
            OutIndex = MirrorArray*InIndex; %齐次坐标*变化矩阵
            xOutIndex = round(OutIndex(1,1));%求新坐标X向下取整
            yOutIndex = round(OutIndex(2,1));%求新坐标Y向下取整
            if (yOutIndex<=n)&&(xOutIndex <= m)&&(yOutIndex >= 1)&&(xOutIndex >= 1)%判断新点是否在坐标系内
                OutImage(yOutIndex,xOutIndex,:) = InputImage(yIndex,xIndex,:);
            end
        end
    end
OutImage = uint8(OutImage);
end