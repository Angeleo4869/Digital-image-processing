# Digital-image-processing

## 实验一 **图像增强算法**：

### **一、实验目的**

1、了解在空域图像增强中常用的典型算法：线性对比度展宽、直方图均衡化。使学生通过对图像采用线性对比度展宽、直方图均衡化的方法进行处理，获得图像画质的改善。

2、掌握线性对比度展宽方法的工作原理和算法实现。

3、掌握直方图均衡化方法的工作原理和算法实现。

### **二、实验内容**

#### 1，实现线性密度展宽算法

```matlab
function [G]=ContrastWidening(ImPath,fa,fb,ga,gb`)
```

#### 2、实现灰度图像的直方图均衡化算法

`

```matlab
function [G] = imhisteq(F)
```



#### 3、实现彩色图像的直方图均衡化算法（算法流程可以参考灰度图像的直方图均衡化算法）

```matlab
function [G] = imhisteq_C(F)
```

`

## 实验二 **图像几何变换**：

### **一、实验目的**

1、通过编程实现图像缩放算法、镜像算法，加深对于该算法的原理和工作过程的理解；

2、理解图像仿射变换的工作原理。了解各种不同形式的仿射变换矩阵。

3、通过编程实现图像旋转、仿射变换。

### **二、实验内容**

#### 1、实现图像水平镜像

```matlab
function [OutImage] = mirror_horizontal(InputImage)
```



#### 2、**实现直角坐标系中的图像缩小**

```matlab
function im = rsz_S1(I,kr,kc)
```



#### 3、**实现基于仿射变换的图像变换**

```matlab
function [im] = aff(I,A)
```



## **实验三 **图像噪声去除：

### **一、实验目的**

1、掌握基于均值平滑操作的信号去噪方法的基本原理（适用于一维或二维信号的情况）。了解加性噪声和乘性噪声各自的特点。

2、掌握均值滤波器的工作原理和算法实现。

3、掌握中值滤波器的工作原理和算法实现。

4、理解边界保持类滤波器的工作原理。

5、掌握KNN（K近邻平滑滤波器）、SNN（对称近邻平滑滤波器）的算法思想及代码实现。

### **二、实验内容**

#### **1**、调用MATLAB自带函数imnoise、medfilt2、filter2实现如下功能：

（1）生成含有高斯噪声、椒盐噪声的图像

（2）使用均值滤波分别对高斯噪声、椒盐噪声的图像进行滤波。

（3）使用中值滤波分别对高斯噪声、椒盐噪声的图像进行滤波。

代码详情请见”代码.txt“

#### **2、实现KNN（K近邻平滑滤波器）**

```matlab
function [im_filered] = KNN_denoise (I,K,N)
```



#### **3、实现SNN（对称近邻平滑滤波器）**

```matlab
function [im_filered] = SNNFilter(im_noise,n)
```

## **实验**4 **图像锐化**

### **一、实验目的**

1、掌握一阶锐化算法的工作原理和算法实现。

2、掌握二阶锐化算法的工作原理和算法实现。

### **二、实验内容**

#### **1、实现拉普拉斯锐化。**

```matlab
% 输入原始图像
im = imread('im\Grayblur6.png');imshow(im);
im = double(im);

H1 = [0 -1 0;-1 4 -1;0 -1 0];
im_filter1 = filter2(H1,im);

% 拉普拉斯锐化得到H1图像
im2_1 = im_filter1 + im;
figure,imshow(uint8(im2_1));

maxV = max(max(im_filter1));
minV = min(min(im_filter1));

%拉普拉斯锐化图像
delta = 0;
if(minV<0)
    delta = abs(minV);
end
im1 = im_filter1 + delta;
figure,imshow(uint8(im1));

```

[^由于代码较容易，故未采用函数式，而是直接在matlab命令上运行]: 

#### 2、**实现Sobel微分算子**

```matlab
% Sobel锐化   
% g(i,j)=[dx(i,j)^2+dy(i,j)^2]^(1/2);
% dx = [-1 -2 -1;0 0 0;1 2 1]; dy = [-1 0 1;-2 0 2;-1 0 1];

% 原始图像
im = imread('im\Grayblur6.png');
imshow(im);
im = double(im);

H1 = [-1 -2 -1;0 0 0;1 2 1];
dx = filter2(H1,im);
H2 = [-1 0 1;-2 0 2;-1 0 1];
dy = filter2(H2,im);

im2 = sqrt(dx.^2 + dy.^2); % .^2:矩阵中的每个元素都求平方

%Sobel锐化所得的图像
figure,imshow(uint8(im2));
im3 = im + sqrt(dx.^2 + dy.^2)*0.1;

%Sobel锐化并叠加原图所得的图像
figure,imshow(uint8(im3));

```

#### 3、**实现交叉微分算法（Roberts算法）**

```matlab
% 交叉微分算法（Roberts算法）
% g( i, j)= |f(i+1,j+1)-f(i,j)|+ |f(i+1,j)-f(i,j+1)|

%原始图像
im = imread('im\Grayblur6.png');imshow(im);title('原始图像');

[h,l,c] = size(im);%得到im的行列数与颜色通道
f = double(im);
g = zeros(h,l);%初始化输出矩阵g
for i=1:h-1
    for j=1:l-1
        % 交叉微分，根据以下公式，由F(i,j)、F(i+1,j)、F(i,j+1)、F(i+1,j+1)计算G(i,j)
        g(i,j) = abs(f(i+1,j+1)-f(i,j)) + abs(f(i+1,j)-f(i,j+1));
    end
end
im2 = uint8(g);
figure,imshow(im2);title('交叉微分/Roberts锐化所得的图像');
figure,imshow(uint8(g+f));title('交叉微分/Roberts锐化并叠加原图所得的图像');

```

## 实验五 图像分割

### 一、**实验目的**

1、掌握p参数分割的工作原理和算法实现

2、掌握均匀性度量法分割的工作原理和算法实现

### **二、实验内容**

#### **1、实现P-参数法的图像分割**

```matlab
function [Im2] = pParam0(Im,perct)
```

#### 2、**实现均匀性度量法的图像分割**

```matlab
function [Im2,BestC1Thrd] = jyxdl(Im)
```

