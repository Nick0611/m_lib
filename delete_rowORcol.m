%%% ɾ������ȫ���л���ȫ����
% ����1������
% ����'type'��'c'����ɾ��ȫ���У�'r'����ɾ��ȫ����,Ĭ��ɾ��ȫ����

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
