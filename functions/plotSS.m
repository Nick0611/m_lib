%%% function plotS(varargin)
%���� ����ÿ�������꣬Ȼ������
%����1 �������
%����2 ÿ���������������������д��
%��� ͼ
% ���ߣ������d
% ʱ�䣺2022-4-28
% �޸�2022-6-22
% �����������p

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