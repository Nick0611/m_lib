%%% function plotS(varargin)
%���� ����ÿ�������꣬Ȼ������
%���� ÿ���������������������д��
%��� ͼ
% ���ߣ������d
% ʱ�䣺2022-3-15
% �޸ģ���ʹ��plotSS������varargin����ͬʱ���������Ը�ֵ��
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