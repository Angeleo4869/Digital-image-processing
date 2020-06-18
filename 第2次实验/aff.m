% 实现基于仿射变换的图像变换

% 
% 测试代码1
% I =imread('.\im\peppers.png'); 
% dy=0.5;
% A=[1 0 0;dy 1 0;0 0 1];                     
% im = aff(I,A);                         
% figure,imshow(I);figure, imshow(im);

% 测试代码2
% I =imread('.\im\peppers.png');
% delta_ang = 30;
% q=delta_ang*pi/180;
% A=[cos(q) -sin(q) 0;sin(q) cos(q) 0;0 0 1];  %求旋转变换矩阵
% im=aff(I,A) ;                          
% figure,imshow(I);figure, imshow(im);


function [im] = aff(I,A)
[N,M,C] = size(I);%2、获得图像尺寸，计算图像的四个顶点的x、y坐标 。
InvA = inv(A);%1、求仿射变换A的逆变换矩阵InvA。

x1 = 1;x2 = N;x3 = N;x4 = 1;
y1 = 1;y2 = 189;y3 = M;y4 = M;
x = [x1,x2,x3,x4];
y = [y1,y2,y3,y4];
d1 = ones(1,4);
rst = round(A*[x;y;d1]);%3、根据仿射变换公式：rst=A*[x; y;1]，
%计算图像的四个顶点旋转后的坐标。
%（x、y为原始图像的坐标，rst(1,:)是旋转后的行坐标，rst(2,:)是旋转后的列坐标）
xmin = min(rst(1,:));
xmax = max(rst(1,:));
ymin = min(rst(2,:));
ymax = max(rst(2,:));


if xmin < 0
    deltaX = abs(xmin)+1;
else 
    deltaX = 0;
end
if ymin < 0
    deltaY = abs(ymin)+1;
else 
    deltaY = 0;
end
%4、根据四个顶点旋转后的坐标，计算画布扩展后的大小M2、N2，
%并计算x和y方向的偏移量deltaX、deltaY。初始化新图新im
N_2 = xmax-xmin+1;
M_2 = ymax-ymin+1;
im = ones(N_2,M_2,C)*(-1);
%5、对新图像G的每一行for i=1:M_2
%6、对新图像G的每一列for j=1:N_2
for i = 1:N_2
    for j = 1:M_2
        % 6.1
        % 根据仿射变换的逆变换矩阵InvA，计算像素点G(i,j,:)
        %旋转前在原图像F中的坐标x、y(rst=InvA*[i-deltaX ;j-deltaY; 1 ])。
        rst = InvA*[i-deltaX  j-deltaY  i]';        x = rst(1);
        y = rst(2);
        x = round(x);
        y = round(y);
        %6.2 如果(x>0 && x<=M && y>0 && y<=N)，则将F(x,y,:)的像素值采样并且赋给im(i,j,:)
        if(x>0 && x<=N && y>0 && y<=M)
            im(i,j,:)=I(x,y,:);
        end
    end
end
    im = uint8(im);
end


