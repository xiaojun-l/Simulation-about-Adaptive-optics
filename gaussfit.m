function b = gaussfit(X,Y)
%��������һ�����ݵĸ�˹�������ֵ
%   X���Ա�����Y�����������X��Y���������������ǵ�Ԫ�ظ����������
%   X��Y����������������ʽ����
%   Guass����y=A*exp(-(x-mu)^2/2),ת��Ϊ���Է���Ϊ1ny=(lnA-mu^2/s)+2*mu*x/s-x^2/s
%   ��С�������

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

