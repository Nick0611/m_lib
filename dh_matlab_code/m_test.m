%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            函数测试代码
% 
% 1、D-H参数输入格式：
%    [连杆1长度a1 连杆1扭角aerf1 关节1偏移量d1 关节1角度theta1;
%     连杆2长度a2 连杆2扭角aerf2 关节2偏移量d2 关节2角度theta2;
%                            ....                            ]  
% 
% 注：具体信息可去我博客查看：
% 2019年5月15日
% csdn博客名：BinHeon
%           https://blog.csdn.net/BinHeon/article/details/90245890
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear;
%%%% %%%% %%%% 方法一：直接读取excel中的DH参数表用于计算
%[~,~,dh_table] = xlsread('dh_test.xlsx','sheet1','B2:E8'); % 导入excel中参数表

%%%% %%%% %%%% 方法二：手动自建具有DH参数的符号矩阵
% DH_TABLE = str2sym('[l11*l13,0,0,theta10;l12+l2,0,0,90;l2,0,0,theta32;l3,0,0,theta43;0,0,0,theta54;l5,0,0,theta65;l6,0,0,0]')
syms l11 l13 l12 l2 l3 l5 l6 theta10 theta32 theta43 theta54 theta65
DH_TABLE = [l11*l13, 0, 0, theta10;
            l12+l2 , 0, 0, 90;
            l2     , 0, 0, theta32;
            l3     , 0, 0, theta43;
            0      , 0, 0, theta54;
            l5     , 0, 0, theta65;
            l6     , 0, 0, 0       ];


%%%% %%%% %%%% 获得DH矩阵
[Dof,A] = m_SigalMesu(DH_TABLE);

%%%% %%%% %%%% 计算0-1-2之间的转换矩阵，并化简 
T = simplify(A(:,:,1)*A(:,:,2))

%%%% %%%% %%%% 带入具体数值求得 T 所对应的值 T1
%%%% 将theta10 = 90°，l11 = 1，l12 = 2 ,l2 = 3，l3 = 0.5 带入T矩阵
T1 = subs(T,[theta10 l11 l12 l2 l3],[90 1 2 3 0.5])



