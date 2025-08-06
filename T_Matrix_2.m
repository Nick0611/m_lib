%% T_Matrix_2
% 输入1~输入6：前三个参数分别是按照顺规顺序的绕轴转动的 弧度，要注意区分  后三个参数是xyz三个方向的平动
% 输入7：顺规
% 输入8：Eular | rpy
% 输出1：R
% 输出2：T
% 默认Eular，Z-Y-X顺规；默认输出旋转矩阵R
% Revision2024-6-19，源代码有个bug，只能处理zyx或者xyz或者x/y/z三个轴都存在的情况，对于xzx这种就不能处理了，
% 因为默认前三个参数是绕x绕y绕z轴的转角，所以更新为T_Matrix_2函数

function [varargout]=T_Matrix_2(varargin)
R = eye(3);
if isempty(varargin)
    fprintf("       T_Matrix: Please give correct input!");
    return;
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

if(lower(str2) == "eular")
    for i = 1:length(S)
        s(i) = char(S(i));
        switch s(i)
            case 'x'
                R = R*[1 0 0; 0 cos(varargin{i}) -sin(varargin{i}); 0 sin(varargin{i}) cos(varargin{i})];
            case 'y'
                R = R*[cos(varargin{i}) 0 sin(varargin{i}); 0 1 0; -sin(varargin{i}) 0 cos(varargin{i})];
            case 'z'
                R = R*[cos(varargin{i}) -sin(varargin{i}) 0; sin(varargin{i}) cos(varargin{i}) 0; 0 0 1];
        end
    end
end
if(lower(str2) == "rpy")
    for i = 1:length(S)
        s(i) = char(S(i));
        switch s(i)
            case 'x'
                R = [1 0 0; 0 cos(varargin{i}) -sin(varargin{i}); 0 sin(varargin{i}) cos(varargin{i})]*R;
            case 'y'
                R = [cos(varargin{i}) 0 sin(varargin{i}); 0 1 0; -sin(varargin{i}) 0 cos(varargin{i})]*R;
            case 'z'
                R = [cos(varargin{i}) -sin(varargin{i}) 0; sin(varargin{i}) cos(varargin{i}) 0; 0 0 1]*R;
        end
    end
end
if nargout >=0
    varargout{1} = R;
end
if nargout == 2
    varargout{2} = [R,[a;b;c];zeros(1,3),1];
end
