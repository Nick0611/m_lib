% %%%%%%%%%%%%%%%%%%%% KD区间树 %%%%%%%%%%%%%%%%%%%%
% classdef IntervalTreeNode
%     properties
%         Interval   % 区间 [start, end]
%         Max        % 当前子树中的最大端点
%         Left = []  % 左子节点
%         Right = [] % 右子节点
%     end
%     
%     methods
%         function obj = IntervalTreeNode(interval)
%             if nargin > 0
%                 obj.Interval = interval;
%                 obj.Max = max(interval, [], 2);
%             end
%         end
%     end
% end
% %%%%%%%%%%%%%%%%%%%% KD区间树 %%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%% KD区间树上进一步增加节点可行性信息 %%%%%%%%%%%%%%%%%%%%
classdef IntervalTreeNode
    properties
        Interval   % 区间矩阵，每行表示一个维度的 [start, end]
        Max        % 当前子树中的最大端点，每个维度的最大值
        Min        % 当前子树中的最小端点，每个维度的最小值
        Left = []  % 左子节点
        Right = [] % 右子节点
        IsFeasible % 是否满足约束条件
    end
    
    methods
        function obj = IntervalTreeNode(interval, isFeasible)
            if nargin > 0
                obj.Interval = interval;
                obj.Max = max(interval, [], 2);
                obj.Min = min(interval, [], 2);
                obj.IsFeasible = isFeasible;
            end
        end
    end
end
% %%%%%%%%%%%%%%%%%%%% KD区间树上进一步增加节点可行性信息 %%%%%%%%%%%%%%%%%%%%
