function y = Bernoulli(i);
%生成i个呈伯好努利分布，P(ai=+-sigma)=0.5的序列

y1=rand(1,i);
y1=round(y1);

idx=y1==0;
y1(idx)=-1;

y=y1;