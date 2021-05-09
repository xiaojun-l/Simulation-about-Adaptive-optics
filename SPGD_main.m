clear;close all;clc
% 读取图像
input = double(imread('test_image\5.bmp'));
input = input./max(input(:));

figure();imshow(input);
title('原始无像差图像')
% 设置Zernike像差校正阶数及初始像差
N = [2,2,2,3,3,3,3,4];
M = [0,2,-2,1,-1,3,-3,0];
% 设置初始像差系数
abe0 = randn(1,8);

% 计算有像差图像
I_abe0 = Image_with_Aberration(input,N,M,abe0);

figure();imshow(I_abe0);
title('有像差图像')

% 像差校正
iterations = 400;                   % 设置迭代次数
beta = 2;                           % 设置梯度下降算法参数，控制收敛速度
M0 = gradient(I_abe0);              % 计算有像差图像评价函数
abe = abe0;
Me = zeros(1,iterations);
f = waitbar(0,'SPGD算法运行中，请稍候！');
for i = 1:iterations
    Bias = 0.2*Bernoulli(length(N));      % 生成服从伯努利分布的振动系数
    abe1 = abe - Bias;                 % 负扰动系数
    I1 = Image_with_Aberration(input,N,M,abe1);
    M1 = gradient(I1);                  % 计算M-
    abe2 = abe + Bias;                 % 正扰动系数
    I2 = Image_with_Aberration(input,N,M,abe2);
    M2 = gradient(I2);                  % 计算M+
    
    abe = abe + beta*Bias*(M2-M1);      % 更新像差系数
    I = Image_with_Aberration(input,N,M,abe);
    Me(i) = gradient(I);
    waitbar(i/iterations);
end
close(f);
figure();plot(Me);title('SPGD迭代曲线');
figure();imshow(I);title('校正后图像')
figure();bar(4:11,abe0);
hold on;bar(4:11,abe);
xlabel('Zernike阶数');
ylabel('Zernike系数');
legend('校正前像差系数','校正后像差系数')
