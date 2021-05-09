clear;close all;clc
% ��ȡͼ��
input = double(imread('test_image\5.bmp'));
input = input./max(input(:));

figure();imshow(input);
title('ԭʼ�����ͼ��')
% ����Zernike���У����������ʼ���
N = [2,2,2,3,3,3,3,4];
M = [0,2,-2,1,-1,3,-3,0];
% ���ó�ʼ���ϵ��
abe0 = randn(1,8);

% ���������ͼ��
I_abe0 = Image_with_Aberration(input,N,M,abe0);

figure();imshow(I_abe0);
title('�����ͼ��')

% ���У��
iterations = 400;                   % ���õ�������
beta = 2;                           % �����ݶ��½��㷨���������������ٶ�
M0 = gradient(I_abe0);              % ���������ͼ�����ۺ���
abe = abe0;
Me = zeros(1,iterations);
f = waitbar(0,'SPGD�㷨�����У����Ժ�');
for i = 1:iterations
    Bias = 0.2*Bernoulli(length(N));      % ���ɷ��Ӳ�Ŭ���ֲ�����ϵ��
    abe1 = abe - Bias;                 % ���Ŷ�ϵ��
    I1 = Image_with_Aberration(input,N,M,abe1);
    M1 = gradient(I1);                  % ����M-
    abe2 = abe + Bias;                 % ���Ŷ�ϵ��
    I2 = Image_with_Aberration(input,N,M,abe2);
    M2 = gradient(I2);                  % ����M+
    
    abe = abe + beta*Bias*(M2-M1);      % �������ϵ��
    I = Image_with_Aberration(input,N,M,abe);
    Me(i) = gradient(I);
    waitbar(i/iterations);
end
close(f);
figure();plot(Me);title('SPGD��������');
figure();imshow(I);title('У����ͼ��')
figure();bar(4:11,abe0);
hold on;bar(4:11,abe);
xlabel('Zernike����');
ylabel('Zernikeϵ��');
legend('У��ǰ���ϵ��','У�������ϵ��')
