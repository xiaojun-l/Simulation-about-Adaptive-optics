clear;close all;clc

% ��ȡͼ��
input = double(imread('test_image\9.bmp'));
input = input./max(input(:));

figure();imshow(input);
title('ԭʼ�����ͼ��')
% ����Zernike���У����������ʼ���
N = [2,2,2,3,3,3,3,4];
M = [0,2,-2,1,-1,3,-3,0];
% ���ó�ʼ���ϵ��
abe0 = 4*randn(1,8);

% ���������ͼ��
[I_abe0,~,~] = Image_with_Aberration(input,N,M,abe0);
M0 = gradient(I_abe0);
figure();imshow(I_abe0);title('�����ͼ��')
% ģʽ��У��
abe = zeros(1,length(N));
% ����ÿ�ױ궨ϵ��
b = 0.5;
x = reshape((-2*b:b:2*b),[5,1]);
y = zeros(5,1);

for i = 1:length(N)
    abe1 = abe;
    for j = 1:5
        if x(j) == 0
            y(j) = M0;
        else
            abe1(i) = abe1(i) + x(j);
            [I,~,~] = Image_with_Aberration(input,N,M,abe1);
            y(j) = gradient(I);
        end
    end
    abe(i) = gaussfit(x,y);    
end

[I,~,~] = Image_with_Aberration(input,N,M,abe);
figure();imshow(I);title('У����')

figure();bar(4:11,abe0);
hold on;bar(4:11,abe);
xlabel('Zernike����');
ylabel('Zernikeϵ��');
legend('У��ǰ���ϵ��','У�������ϵ��')