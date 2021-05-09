function Phase = ZernikeSum(n,m,coff,r,theta)
%此函数用于求解若干Zernike多项式之和
%   [n,m]为Zernike项阶数
%   coff为Zernike系数，n,m,coff维数大小必须相同
%   size为结果矩阵的横纵向采样数
y = zernfun(n,m,r,theta,'norm');
z = zeros(size(r));
for i = 1:length(m)
    z = z + coff(i) .* y(:,i);
end
Phase = z;
end

