%%% label
% ���� Ϊͼ��������
% ���� �����d
% Date 2021-06-21
% Ч�� ����0������Ĭ�ϱ�xyz
%      ����1������ֻ��x��
%      ����2������ֻ��x��y��
%      ����3������ֻ��x��y��z��
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
