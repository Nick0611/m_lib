%%% function plotS(varargin)
%功能 给定每个点坐标，然后连线
%输入1 点的数量
%输入2 每个点的坐标列向量，依次写出
%输出 图
% 作者：梁振鹍
% 时间：2022-4-28
% 修改2022-6-22
% 增加输出属性p

function p = plotSS(num,varargin)
n = size(varargin{1},1);
if n == 2
    if num == nargin-1
        for i = 1:num-1
            p(i) = line([varargin{i}(1);varargin{i+1}(1)],[varargin{i}(2);varargin{i+1}(2)]);
        end
    else
        for i = 1:num-1
            p(i) = line([varargin{i}(1);varargin{i+1}(1)],[varargin{i}(2);varargin{i+1}(2)],varargin{num+1:end});
        end
    end
else
    view(3)
    if num == nargin-1
        for i = 1:num-1
            p(i) = line([varargin{i}(1);varargin{i+1}(1)],[varargin{i}(2);varargin{i+1}(2)],[varargin{i}(3);varargin{i+1}(3)]);
        end
    else
        for i = 1:num-1
            p(i) = line([varargin{i}(1);varargin{i+1}(1)],[varargin{i}(2);varargin{i+1}(2)],[varargin{i}(3);varargin{i+1}(3)],varargin{num+1:end});
        end
    end
end