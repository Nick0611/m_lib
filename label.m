%%% label
% 功能 为图添加轴标题
% 作者 梁振鹍
% Date 2021-06-21
% 效果 输入0参数，默认标xyz
%      输入1参数，只标x轴
%      输入2参数，只标x轴y轴
%      输入3参数，只标x轴y轴z轴
function label(varargin)
switch nargin
    case 0
        xlabel('x')
        ylabel('y')
        zlabel('z')
    case 1
        xlabel(varargin{1})
    case 2
        xlabel(varargin{1})
        ylabel(varargin{2})
    case 3
        xlabel(varargin{1})
        ylabel(varargin{2})
        zlabel(varargin{3})
end
