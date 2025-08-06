%%% function varargout = normS(varargin)
% 输入列向量组 3 by n
% 每列都单位化后输出 3 by n
% 或者输入 1 by n，按照行向量单位化
% 时间：2022-7-28
% 作者：Zachary Leung
% Revision 20230528
% 增加了norm为0的输出，此时默认输出[0;0;1]
function varargout = normS(varargin)
if size(varargin{1},1) == 1
    for i = 1:size(varargin{1},2)
        if norm(varargin{1}) ~= 0
            varargout{1}(1,i) = varargin{1}(1,i)/norm(varargin{1});
        else
            varargout{1}(1,i) = [0;0;1];
%             disp('长度为零！\n');
        end
    end
else
    for i = 1:size(varargin{1},2)
        if norm(varargin{1}(:,i)) ~= 0
            varargout{1}(:,i) = varargin{1}(:,i)/norm(varargin{1}(:,i));
        else
            varargout{1}(:,i) = [0;0;1];
%             disp('长度为零！\n');
        end
    end
end