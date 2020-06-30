%测试代码如下：
%Im=imread('yw2_g.jpg'); 
%Im2=pParam0(Im,0.7974);
%imshow(Im2);
%
%

function [Im2] = pParam0(Im,perct)
bestDelta = Inf;
BestThrd = 0;
[m,n] = size(Im);%得到图像大小
for Thrd = 0:255
    ind1 = find(Im<=Thrd);
    ind2 = find(Im>Thrd);
    if(~isempty(ind1)&& ~isempty(ind2))
        p1 = length(ind1)/(m*n);
        p2 = length(ind2)/(m*n);
        Delta = abs(p2-perct);
        if(Delta < bestDelta);
            BestThrd = Thrd;
            bestDelta = Delta;
        end
    end
end

Im2 = zeros(m,n);
Im2( find(Im > BestThrd)) = 1;
Im2 = logical(Im2);

end
