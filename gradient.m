function M = gradient(I3)
I3=double(I3);
%[m,n]=size(I3);
IX3 = conv2(I3,[-1,-2,-1;0,0,0;1,2,1]);
IY3 = conv2(I3,[-1,-2,-1;0,0,0;1,2,1]');
II3=sqrt(IX3.^2+IY3.^2);
M=sum(sum(II3))/sum(sum(I3));