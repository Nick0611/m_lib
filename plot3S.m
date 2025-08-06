%%% plot3S
% data 2021-6-12
% input 点阵数组，3*n；或者3*n*l
% 若输入为3*n，则以每一列为一个点进行作图，一条折线包含n个点；
% 若输入为3*n*l，则以每一列为一个点进行作图，一条折线包含n个点，一共l条折线；
% Revision
% Date 2021-6-21
% 严格输入，必须用列向量表示一个点；
% 增加功能，可以输入3*n*l，一条折线包含n个点，一共l条折线；
% Revision
% Date 2023-4.7
% 增加varargin{2:end}，可以使用line的控制属性
% Revision
% Date 2023-4.8
% 可以plot也可以plot3S
% Revision
% Date 2023-4.9
% 输入1 by n的话，横坐标就是1:n
% Revision
% Date 2023-726
% varargin{2:end}修改为varargin{1:end}

function f = plot3S(points,varargin)
Mat = points;
[m,n,l] = size(Mat);
if m == 3
f = plot3(reshape(Mat(1,:,:),n,l),reshape(Mat(2,:,:),n,l),reshape(Mat(3,:,:),n,l),varargin{1:end});
end
if m == 2
    f = plot(reshape(Mat(1,:,:),n,l),reshape(Mat(2,:,:),n,l),varargin{1:end});
end
if m == 1
    f = plot(1:n,reshape(Mat(1,:,:),n,l),varargin{1:end});
end
