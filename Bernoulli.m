function y = Bernoulli(i);
%����i���ʲ���Ŭ���ֲ���P(ai=+-sigma)=0.5������

y1=rand(1,i);
y1=round(y1);

idx=y1==0;
y1(idx)=-1;

y=y1;