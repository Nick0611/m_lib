%%% scatter3S
% data 2021-6-21
% input 点阵数组，3*n
% 若输入为3*n，则以每一列为一个点进行作图；
% Revision
% Date 2021-6-21
% 严格输入，必须用列向量表示一个点
% Revision
% Date 2022-7-15
% 针对不同维度的数组输入，有不同的表现；用varargin{2:end}增加属性控制

function f = scatter3S(varargin)
Mat = varargin{1};
[a,b] = size(Mat);
if a == b && b == 3
    disp("输入三行三列，默认每一列为一个点的坐标。")
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
if a == b && b == 2
    disp("输入两行两列，默认每一列为一个点的坐标。")
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 2 && b>3
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 3 && b>3
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
if b == 2 && a>3
    f = scatter(Mat(:,1),Mat(:,2),varargin{2:end});
    return
end
if b == 3 && a>3
    f = scatter3(Mat(:,1),Mat(:,2),Mat(:,3),varargin{2:end});
    return
end
if a == 2 && b==3
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 3 && b==2
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
if a == 1 && b==2
    f = scatter(Mat(:,1),Mat(:,2),varargin{2:end});
    return
end
if b == 1 && a==2
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 1 && b==3
    f = scatter3(Mat(:,1),Mat(:,2),Mat(:,3),varargin{2:end});
    return
end
if b == 1 && a==3
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
disp('Wrong Input!')
