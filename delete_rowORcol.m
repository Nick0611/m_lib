%%% 删除矩阵全零行或者全零列
% 输入1：矩阵
% 输入'type'：'c'代表删除全零列，'r'代表删除全零行,默认删除全零行

function [varargout] = delete_rowORcol(varargin)
a = varargin{1};
type = 'r';
if nargin > 1
    for i = 2:nargin-1
        switch varargin{i}
            case 'type'
                type = lower(varargin{i+1});
        end
    end
end
switch type
    case 'r'
        a(all(a==0,2),:) = [];
    case 'c'
        a(:,all(a==0,1)) = [];
end
varargout{1} = a;
