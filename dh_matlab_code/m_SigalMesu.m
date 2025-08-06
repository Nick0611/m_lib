%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     符号矩阵计算DH转换矩阵公式
% 1、函数功能：[Dof,A] = m_SigalMesu(DH_table_or_excelname,sheetname,range)
%    利用符号矩阵 or excel文件导入 D-H参数表，自动获得转换矩阵
%    DH_table_or_excelname —— DH参数符号矩阵 or 具有DH参数便表的excel文件名
%    sheetname —— 只有在excel导入时候才有作用，它表示导入数据在excel文件的sheetname sheet中
%    range —— 只有在excel导入时候才有作用，它表示DH参数表范围
%    Dof —— 转换矩阵个数
%    A   —— 转换矩阵，三维数据。A(:,:,i)为求得的第i个DH字符矩阵
%
% 2、D-H参数输入格式：
%    [连杆1长度a1 连杆1扭角aerf1 关节1偏移量d1 关节1角度theta1;
%     连杆2长度a2 连杆2扭角aerf2 关节2偏移量d2 关节2角度theta2;
%                            ....                            ]   
%    符号矩阵直接创建方法：
%    1）M = sym('[a,2*b;3*a,0]');
%    2) M = str2sym('[a,2*b;3*a,0]');
%  注：sym函数可能不再适用
%
% 3、从excel导入输入格式：
%    [Dof,A] = m_SigalMesu('excelname','sheetname','range')
%  如：[Dof,A] = m_SigalMesu('dh_test.xlsx','sheet1','B2:E8')
%
%
%
%  注：该函数如果输入一个参数，则表示输入为DH参数符号矩阵；
%      如果需要从excel导入，则需要根据自己建立的参数表输入：
%      excel文件名、sheet名、甚至对应DH参数范围
%      为standard-DH矩阵，即后置
%
% 2019年5月15日
% csdn博客名：BinHeon
%           https://blog.csdn.net/BinHeon/article/details/90245890
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Dof,A] = m_SigalMesu(DH_table_or_excelname,sheetname,range)

%%%% %%%% %%%% 输入参数处理
if nargin == 1       %%%% 输入一个参数则默认该参数为DH参数字符矩阵
    DH_table = DH_table_or_excelname;
end
if nargin == 3       %%%% 输入三个参数则默认第一参数为excel名、第二为sheet名、第三为表范围
% 读取excel文件中的数据方法：
% 方法1：[data,text] = xlsread(FileName, SheetName, Range);
% data保存的是数据单元格的值， text保存的是字符串单元格的内容
% 方法2：[~,~,dh_table] = xlsread(FileName, SheetName, Range);
    [~,~,dh_table] = xlsread(DH_table_or_excelname,sheetname,range); % 导入excel中参数表
    DH_table = sym(dh_table); % 将导入参数表字符化
end

%%%% %%%% %%%% 获得D-H参数表中 转换矩阵数目
[m,n] = size(DH_table); % m为数目
Dof = m;
%%%% %%%% %%%% 计算每个转换矩阵
%%%% 定义符号变量
% syms c_theta s_theta c_aerf s_aerf a d; % 定义符号变量
% %%%% 定义d-h转换矩阵公式 
% dh_A = [c_theta , -s_theta*c_aerf , s_theta*s_aerf , a*c_theta ;
%         s_theta ,  c_theta*c_aerf , -c_theta*s_aerf, a*s_theta ;
%         0       ,     s_aerf      ,     c_aerf     ,     d     ;
%         0       ,       0         ,        0       ,     1      ];% D-H计算公式

syms a aerf d theta; % 定义符号变量：a连杆长度 aerf连杆扭角 d关节偏移 theta关节转角
%%%% 定义d-h转换矩阵公式 
dh_A = [cos(theta) , -sin(theta)*cos(aerf) , sin(theta)*sin(aerf) , a*cos(theta) ;
        sin(theta) ,  cos(theta)*cos(aerf) , -cos(theta)*sin(aerf), a*sin(theta) ;
           0       ,       sin(aerf)       ,       cos(aerf)      ,       d      ;
           0       ,            0          ,            0         ,       1      ];% D-H计算公式

%%%% 计算每个转换矩阵 Ai ,并将 Ai 组成三维矩阵 A 保存；从而方便函数返回
for i=1:m % 总共有 m 个 转换矩阵

    % 根据D-H参数表初始化对应D-H参数
    t_a = DH_table(i,1);    % 获得D-H参数表中第i个d-h参数的 连杆长度
    t_aerf = DH_table(i,2); % 获得D-H参数表中第i个d-h参数的 连杆扭角
    t_d = DH_table(i,3);    % 获得D-H参数表中第i个d-h参数的 关节偏移
    t_theta = DH_table(i,4);% 获得D-H参数表中第i个d-h参数的 关节偏角
    % 获得带入参数后的符号矩阵，即转换矩阵A(i)
    A(:,:,i) = subs(dh_A,[a aerf d theta],[t_a t_aerf t_d t_theta]);
       % 初始化三维矩阵A中第i个二维矩阵为D-H矩阵
           % 注意，subs函数它并不改变原来的dh_A的符号矩阵
               % 它只是返回带入dh_A符号矩阵所得到的新符号矩阵
    
end


