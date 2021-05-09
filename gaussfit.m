function b = gaussfit(X,Y)
%本函数求一组数据的高斯拟合中心值
%   X是自变量，Y是因变量，且X与Y必须是向量且它们的元素个数必须相等
%   X和Y必须以列向量的形式输入
%   Guass函数y=A*exp(-(x-mu)^2/2),转化为线性方程为1ny=(lnA-mu^2/s)+2*mu*x/s-x^2/s
%   最小二乘拟合

Z=log(Y);
n=length(Y);

fai0=ones(n,1);
fai1=X;
fai2=X.^2;

A=[0 sum(fai0.*fai1) sum(fai0.*fai2);0 0 sum(fai1.*fai2);0 0 0];
X1=A+A'+[sum(fai0.^2) 0 0;0 sum(fai1.^2) 0;0 0 sum(fai2.^2)];
Z1=[sum(Z.*fai0);sum(Z.*fai1);sum(Z.*fai2)];
B=X1\Z1;%X1^(-1)*Z1
b=-0.5*B(2)/B(3);
%c=sqrt(b/B(2));
%a=exp(B(1)+b^2/(2*c^2));
%M=[a,b];
end

