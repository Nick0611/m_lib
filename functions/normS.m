%%% function varargout = normS(varargin)
% ������������ 3 by n
% ÿ�ж���λ������� 3 by n
% �������� 1 by n��������������λ��
% ʱ�䣺2022-7-28
% ���ߣ�Zachary Leung
% Revision 20230528
% ������normΪ0���������ʱĬ�����[0;0;1]
function varargout = normS(varargin)
if size(varargin{1},1) == 1
    for i = 1:size(varargin{1},2)
        if norm(varargin{1}) ~= 0
            varargout{1}(1,i) = varargin{1}(1,i)/norm(varargin{1});
        else
            varargout{1}(1,i) = [0;0;1];
%             disp('����Ϊ�㣡\n');
        end
    end
else
    for i = 1:size(varargin{1},2)
        if norm(varargin{1}(:,i)) ~= 0
            varargout{1}(:,i) = varargin{1}(:,i)/norm(varargin{1}(:,i));
        else
            varargout{1}(:,i) = [0;0;1];
%             disp('����Ϊ�㣡\n');
        end
    end
end