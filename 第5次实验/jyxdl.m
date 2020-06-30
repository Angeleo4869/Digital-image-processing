%测试代码如下：
%Im=imread('cameraman.tif'); 
%[Im2,BestClThrd]=jyxdl(Im);
%imshow(Im2);


function [Im2,BestC1Thrd] = jyxdl(Im)
BestCost = Inf;
BestC1Thrd = 0;
[m,n]=size(Im);
for C1Thrd = 0:255
    ind1 = find(Im<=C1Thrd);
    ind2=find(Im>C1Thrd);
    if(~isempty(ind1) && ~isempty(ind2))
%         将原图分为两类
        mu1 = mean(Im(ind1));
        mu2 = mean(Im(ind2));
%         分别计算两类的类内方差：
        sigma1_sq = sum((Im(ind1)-mu1).^2);
        sigma2_sq = sum((Im(ind2)-mu2).^2);
%         统计该类像素对图像的影响程度。
        p1 = length(ind1)/(m*n);%计算第一类像素在图像的分布概率
        p2 = length(ind2)/(m*n);%计算第二类像素在图像的分布概率
        Cost = p1*sigma1_sq + p2*sigma2_sq;
        if( Cost < BestCost);%选择最佳阈值
            BestC1Thrd = C1Thrd;
            BestCost = Cost;
        end
    end
end
Im2 = zeros(m,n);
Im2(find(Im > BestC1Thrd)) = 1;
Im2 = logical(Im2);
end

