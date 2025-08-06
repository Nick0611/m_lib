%%% function plotS(varargin)
%功能 给定每个点坐标，然后连线
%输入 每个点的坐标列向量，依次写出
%输出 图
% 作者：梁振鹍
% 时间：2022-3-15
% 修改：请使用plotSS，运用varargin可以同时给线条属性赋值。
function plotS(varargin)
n = size(varargin{1},1);
if n == 2
    for i = 1:nargin-1
        line([varargin{i}(1);varargin{i+1}(1)],[varargin{i}(2);varargin{i+1}(2)])
    end
else
    view(3)
    for i = 1:nargin-1
        line([varargin{i}(1);varargin{i+1}(1)],[varargin{i}(2);varargin{i+1}(2)],[varargin{i}(3);varargin{i+1}(3)])
    end
end