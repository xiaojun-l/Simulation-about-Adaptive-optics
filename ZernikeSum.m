function Phase = ZernikeSum(n,m,coff,r,theta)
%�˺��������������Zernike����ʽ֮��
%   [n,m]ΪZernike�����
%   coffΪZernikeϵ����n,m,coffά����С������ͬ
%   sizeΪ�������ĺ����������
y = zernfun(n,m,r,theta,'norm');
z = zeros(size(r));
for i = 1:length(m)
    z = z + coff(i) .* y(:,i);
end
Phase = z;
end

