# Simulation-about-Adaptive-optics
This repository contains the simulation programs about wavefront-free adpative optics algorithm

架构
主程序 SPGD_main.m 和 Modal_main.m 是独立的，分别运行SPGD算法和模式法的仿真程序
Imaging 和 Image_quality_evaluation 分支下的文件是SPGD_main.m 和 Modal_main.m 的公共调用部分

    Imaging分支下包含Image_with_aberraiton.m 和 Zernike 分支，Zernike分支下文件归 Image_with_aberration.m 调用
        Zernike 分支包含Zernike_Sum.m 和 zernfun.m，后一文件为前一文件所调用
        
    Image_quality_evaluation 分支下包含四个程序，分别定义四种图像评价函数
    
SPGD 分支内文件 Bernoulli.m 由 SPGD_main.m调用，用于产生N个服从伯努力分布的数值

Modal 分支内文件 gaussfit.m 由 Modal_main.m 调用，用于对X和Y进行高斯拟合，并输出极值对应的横坐标。
