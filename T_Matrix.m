%% T_Matrix
% 绕固定坐标系轴旋转：先绕X转alpha，再绕Y转beta，再绕Z转gamma，则T=Rz(gamma)Ry(beta)Rx(alpha)；
%       如果看成是 固定坐标系 下的坐标变换，即三个旋转角针对的都是 老 坐标系中的三根轴，
%       则 u_老坐标系中的坐标 = T*u_新坐标系中的坐标；
%       如果看成是刚体变换，即在一个固定坐标系中，一个向量绕着固定的三个坐标轴进行转动，
%       u_new_在同一个坐标系下的坐标 = T*u_old；
% Eular角：老坐标系先绕Z转gamma，再绕新Y转beta，再绕新新X转alpha得到新坐标系，
%       则T=Rz(gamma)Ry(beta)Rx(alpha)；
%       如果看成是 随动坐标系 下的坐标变换，即三个旋转角针对的都是 新 坐标系中的三根轴，
%       则 u_老坐标系中的坐标 = T*u_新坐标系中的坐标；
%       如果看成是刚体变换，即在刚体随动坐标系中，一个向量绕着随动坐标系的三个坐标轴进行转动，
%       u_new_在同一个坐标系下的坐标 = T*u_old；
% 卡尔丹（RPY）角：和Eular角形式相同，就是绕的轴不同。
%       先绕X转alpha，再绕新Y转beta，再绕新新Z转gamma，则T=Rx(alpha)Ry(beta)Rz(gamma)；
%   因为R的三列就是变换后的坐标系三根轴在老坐标系下的投影坐标。
% RPY角按旋转先后从右往左乘，Eular角按旋转先后从左往右乘
% 输入1~输入6：前三个参数分别是x、y、z的旋转 弧度，要注意区分  后三个参数是xyz三个方向的平动
% 输入7：顺规
% 输入8：Eular | rpy
% 输出1：R
% 输出2：T
% 默认Eular，Z-Y-X顺规；默认输出旋转矩阵R
% note：不是所有情况下xyz的rpy都等于zyx的eular！矩阵乘法不可交换！
% note：zyx的eular，改变绕z的旋转也就是第一步旋转，末端坐标系才会呈现出绕z的旋转，否则是乱的。
% note：但是rpy由于是随动就不会出现这个问题！
% Revision
% Date 2021-6-20
% 完善help内容
% Revision2024-6-19，源代码有个bug，只能处理zyx或者xyz或者x/y/z三个轴都存在的情况，对于xzx这种就不能处理了，
% 因为默认前三个参数是绕x绕y绕z轴的转角，所以更新了T_Matrix_2函数
%%
function [varargout]=T_Matrix(varargin)
R = eye(3);
if isempty(varargin)
    fprintf("       T_Matrix: Please give correct input!");
    return;
end
if length(varargin) >= 3       % if nargin >= 3
    alpha = varargin{1};       % about x
    beta = varargin{2};        % about y
    gamma = varargin{3};       % about z
end
if length(varargin) == 3 || length(varargin) == 6
    str1 = 'Z-Y-X';        % rotation ordor
    str1 = deblank(str1);
end

if length(varargin) <6
    str1 = lower(varargin{4});
    str1 = deblank(str1);
end
if length(varargin) >= 6       % if nargin == 7
    a = varargin{4};       % along x
    b = varargin{5};       % along y
    c = varargin{6};       % along z
end
if length(varargin) >= 7
    str1 = lower(varargin{7});
    str1 = deblank(str1);
end
str1 = lower(str1);
S = strsplit(str1,{'-'});
str2 = "Eular";
if length(varargin) == 8
    str2 = lower(varargin{8});
    if(~strcmp(str2,"eular") && ~strcmp(str2,"rpy"))
        fprintf("     Please give correct input!\n");
        return
    end
end

Rx = [1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];
Rz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
if(lower(str2) == "eular")
    for i = 1:length(S)
        s(i) = char(S(i));
        switch s(i)
            case 'x'
                R = R*Rx;
            case 'y'
                R = R*Ry;
            case 'z'
                R = R*Rz;
        end
    end
end
if(lower(str2) == "rpy")
    for i = 1:length(S)
        s(i) = char(S(i));
        switch s(i)
            case 'x'
                R = Rx*R;
            case 'y'
                R = Ry*R;
            case 'z'
                R = Rz*R;
        end
    end
end
if nargout >=0
    varargout{1} = R;
end
if nargout == 2
    varargout{2} = [R,[a;b;c];zeros(1,3),1];
end
