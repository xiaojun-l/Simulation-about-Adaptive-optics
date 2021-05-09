function [output,h,Phase] = Image_with_Aberration(input,N,M,coff)
%input为无像差图像
%   N,M为Zernike项阶数，coff为各阶Zernike系数，N,M,coff维度必须相等

% 读取图像维度
[sizex,sizey] = size(input);

% 生成光瞳面相应坐标
x = [1:sizey] - sizey/2;
y = [1:sizex] - sizex/2;
[X,Y] = meshgrid(x,y);
[theta,r] = cart2pol(X,Y);
r = r./min([sizex,sizey])*2;
idx = r <= 1;

% 生成波前相位分布
Phase = zeros(sizex,sizey);
Phase(idx) = ZernikeSum(N,M,coff,r(idx),theta(idx));

% 生成理想光瞳函数
P = zeros(sizex,sizey);
P(idx) = 1;

% 生成强度点扩散函数
h = abs(fftshift(fft2(P.*exp(1i*Phase)))).^2;
h = h./max(max(h));
% 成像过程
% conv2(a,b) 对应频域 F(a)*F(b)

% 生成OTF
H = fft2(h);
H = H./max(max(abs(H)));
INPUT = fft2(input);
OUTPUT = H.*INPUT;
output = abs(ifftshift(ifft2(OUTPUT)));


end

