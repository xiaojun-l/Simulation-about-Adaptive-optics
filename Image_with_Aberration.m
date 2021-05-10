function [output,h,Phase] = Image_with_Aberration(input,N,M,coff)
%inputΪ�����ͼ��
%   N,MΪZernike�������coffΪ����Zernikeϵ����N,M,coffά�ȱ������

% ��ȡͼ��ά��
[sizex,sizey] = size(input);

% ���ɹ�ͫ����Ӧ����
x = [1:sizey] - sizey/2;
y = [1:sizex] - sizex/2;
[X,Y] = meshgrid(x,y);
[theta,r] = cart2pol(X,Y);
r = r./min([sizex,sizey])*2;
idx = r <= 1;

% ���ɲ�ǰ��λ�ֲ�
Phase = zeros(sizex,sizey);
Phase(idx) = ZernikeSum(N,M,coff,r(idx),theta(idx));

% ���������ͫ����
P = zeros(sizex,sizey);
P(idx) = 1;

% ����ǿ�ȵ���ɢ����
h = abs(fftshift(fft2(P.*exp(1i*Phase)))).^2;
h = h./max(max(h));
% �������
% conv2(a,b) ��ӦƵ�� F(a)*F(b)

% ����OTF
H = fft2(h);
H = H./max(max(abs(H)));
INPUT = fft2(input);
OUTPUT = H.*INPUT;
output = abs(ifftshift(ifft2(OUTPUT)));


end

