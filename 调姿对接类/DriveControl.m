%%% function [Drive,gG] = DriveControl(g_OC,g0,gb,num_g,varargin)
    % 功能： 计算每个小车的三个油缸的驱动量
    % 输入1： g_OC，每个小车坐标系相对于全局坐标系坐标系,1 by num_trolley的元胞，每个元胞元素是4 by 4
    % 输入2： g0，每个球头坐标系的初始位置相对于小车坐标系,1 by num_trolley的元胞，每个元胞元素是4 by 4
    % 输入3： g_now，小车球头坐标系当前位置相对小车坐标系，1 by num_trolley的元胞，每个元胞元素是4 by
    % 4，暂时还没想好需不需要这个
    % 输入4： gb，每个球头坐标系相对于活动段自身坐标系,1 by num_trolley的元胞，每个元胞元素是4 by 4
    % 输入5： num_g 需要生成路径的控制点的数量
    % 输入6： g1,g2,...,gnum_g 活动段连体坐标系的途中经过位姿 4 by 4，依次写出
    % 输入7： num_Interpolation 每两个关键点之间的插值点数量，包括起点和终点，默认100
    % 输入8： ControlPointRatio，进行Bezier插值时关键点两侧控制点的伸长率，默认0.2
    % [R1,g1] = T_Matrix(0,0,0,0,0,0,'z-y-x','Eular'); % 刚体连体坐标系的当前位姿
    % [R2,g2] = T_Matrix(pi/24,pi/36,pi/24,20,6,10,'z-y-x','Eular');
    % [R3,g3] = T_Matrix(pi/12,pi/24,pi/12,30,18,16,'z-y-x','Eular'); % 刚体连体坐标系的目标位姿
    % 输出1： Drive 每台车在每个路径点下的各个油缸的驱动量
    % 输出2： gG 每台车的球头在全局坐标系下的每个路径点上对应的位置
    % 作者： Zachary Liang
    % 时间： 2023-6-4
    % Revision 20230727
    % 因为IntrplBezier函数中做了处理，让两段3阶插值的路径的起始点和终止点合二为一，所以数组长度做了修改
function [Drive,gG] = DriveControl(g_OC,g0,g_now,gb,num_g,varargin)
num_trolley = size(g_OC,2);
num_Interpolation = 100;
ControlPointRatio = 0.2;
gB = {};
if nargin>num_g+5
    num_Interpolation = varargin{num_g+1};
end
if nargin>num_g+6
    ControlPointRatio = varargin{num_g+2};
end

% 路径插值
gg = IntrplBezier(ControlPointRatio,num_Interpolation,varargin{1:num_g}); % 李群轨迹插值函数，默认两个关键点之间插值120个，包括首尾关键点
for i = 1:num_g-1
gB = [gB,gg{i}]; % 刚体连体坐标系的插值点处的位姿
end

% 驱动量计算
for i = 1:size(gB,2)
    for j = 1:num_trolley
        gG{i}{j} = gB{i}*gb{j}; % 计算得到的小车球头在全局坐标系中的位姿
        Drive{i}{j} = HydraulicTrolleyXYZInv(g0{j},pinv(g_OC{j})*gG{i}{j}); % 第j个车的第i个轨迹点的运动学逆解
    end
%     DrawCoor(gcf,gB{i},1);
end
