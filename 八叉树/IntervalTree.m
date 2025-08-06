% 区间树
% 时间：2024-7-16
% 来源： ChatGpt
%
% 使用例子：
% tree = IntervalTree();
% tree = tree.insert([15, 20]);
% tree = tree.insert([10, 30]);
% tree = tree.insert([17, 19]);
% tree = tree.insert([5, 20]);
% tree = tree.insert([12, 15]);
% tree = tree.insert([30, 40]);
% 
% % 查询区间
% result = tree.query([14, 16]);
% disp(['Result for [14, 16]: ', num2str(result)]);
% 
% result = tree.query([21, 23]);
% disp(['Result for [21, 23]: ', num2str(result)]);
% 
% % 中序遍历区间树
% tree.inorderTraversal();
% Result for [14, 16]: 1
% Result for [21, 23]: 1
% Interval: [5, 20], Max: 20
% Interval: [10, 30], Max: 30
% Interval: [12, 15], Max: 15
% Interval: [15, 20], Max: 40
% Interval: [17, 19], Max: 40
% Interval: [30, 40], Max: 40

%%%%%%%%%%%%%%%%%%%% 单维度区间树 %%%%%%%%%%%%%%%%%%%%
% classdef IntervalTree
%     properties
%         Root = []
%     end
%     
%     methods
%         function obj = IntervalTree()
%         end
%         
%         function obj = insert(obj, interval)
%             obj.Root = obj.insertNode(obj.Root, interval);
%         end
%         
%         function node = insertNode(obj, node, interval)
%             if isempty(node)
%                 node = IntervalTreeNode(interval);
%                 return;
%             end
%             
%             if interval(1) < node.Interval(1)
%                 node.Left = obj.insertNode(node.Left, interval);
%             else
%                 node.Right = obj.insertNode(node.Right, interval);
%             end
%             
%             node.Max = max(node.Max, interval(2));
%         end
%         
%         function obj = delete(obj, interval)
%             obj.Root = obj.deleteNode(obj.Root, interval);
%         end
%         
%         function node = deleteNode(obj, node, interval)
%             if isempty(node)
%                 return;
%             end
%             
%             if isequal(node.Interval, interval)
%                 if isempty(node.Left)
%                     node = node.Right;
%                 elseif isempty(node.Right)
%                     node = node.Left;
%                 else
%                     temp = obj.findMin(node.Right);
%                     node.Interval = temp.Interval;
%                     node.Right = obj.deleteNode(node.Right, temp.Interval);
%                 end
%             elseif interval(1) < node.Interval(1)
%                 node.Left = obj.deleteNode(node.Left, interval);
%             else
%                 node.Right = obj.deleteNode(node.Right, interval);
%             end
%             
%             if ~isempty(node)
%                 node.Max = max([node.Interval(2), obj.getMax(node.Left), obj.getMax(node.Right)]);
%             end
%         end
%         
%         function maxVal = getMax(~, node)
%             if isempty(node)
%                 maxVal = -inf;
%             else
%                 maxVal = node.Max;
%             end
%         end
%         
%         function result = query(obj, interval)
%             result = obj.queryNode(obj.Root, interval);
%         end
%         
%         function result = queryNode(obj, node, interval)
%             if isempty(node)
%                 result = false;
%                 return;
%             end
%             
%             if obj.isOverlap(node.Interval, interval)
%                 result = true;
%                 return;
%             end
%             
%             if ~isempty(node.Left) && node.Left.Max >= interval(1)
%                 result = obj.queryNode(node.Left, interval);
%             else
%                 result = obj.queryNode(node.Right, interval);
%             end
%         end
%         
%         function bool = isOverlap(~, interval1, interval2)
%             bool = interval1(1) <= interval2(2) && interval2(1) <= interval1(2);
%         end
%         
%         function inorderTraversal(obj)
%             obj.inorder(obj.Root);
%         end
%         
%         function inorder(obj, node)
%             if isempty(node)
%                 return;
%             end
%             obj.inorder(node.Left);
%             disp(['Interval: [', num2str(node.Interval(1)), ', ', num2str(node.Interval(2)), '], Max: ', num2str(node.Max)]);
%             obj.inorder(node.Right);
%         end
%         
%         function node = findMin(~, node)
%             while ~isempty(node.Left)
%                 node = node.Left;
%             end
%         end
% 
%         function plotTree(obj)
%             figure;
%             hold on;
%             axis off;
%             obj.plotNode(obj.Root, 0.5, 1, 0.25, 1);
%             hold off;
%         end
%         
%         function plotNode(obj, node, x, y, xOffset, yOffset)
%             if isempty(node)
%                 return;
%             end
%             
%             plot(x, y, 'ko', 'MarkerFaceColor', 'k');
%             text(x, y, ['[', num2str(node.Interval(1)), ',', num2str(node.Interval(2)), '], Max: ', num2str(node.Max)], ...
%                 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
%             
%             if ~isempty(node.Left)
%                 plot([x, x - xOffset], [y, y - yOffset], 'k-');
%                 obj.plotNode(node.Left, x - xOffset, y - yOffset, xOffset * 0.5, yOffset);
%             end
%             
%             if ~isempty(node.Right)
%                 plot([x, x + xOffset], [y, y - yOffset], 'k-');
%                 obj.plotNode(node.Right, x + xOffset, y - yOffset, xOffset * 0.5, yOffset);
%             end
%         end
%     end
% end
%%%%%%%%%%%%%%%%%%%% 单维度区间树 %%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%% KD区间树 %%%%%%%%%%%%%%%%%%%%
% classdef IntervalTree
%     properties
%         Root = []
%         Dimension % 维度数
%     end
%     
%     methods
%         function obj = IntervalTree(dimension)
%             if nargin > 0
%                 obj.Dimension = dimension;
%             else
%                 obj.Dimension = 1;
%             end
%         end
%         
%         function obj = insert(obj, interval)
%             obj.Root = obj.insertNode(obj.Root, interval, 1);
%         end
%         
%         function node = insertNode(obj, node, interval, depth)
%             if isempty(node)
%                 node = IntervalTreeNode(interval);
%                 return;
%             end
%             
%             cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
%             
%             if interval(cd, 1) < node.Interval(cd, 1)
%                 node.Left = obj.insertNode(node.Left, interval, depth + 1);
%             else
%                 node.Right = obj.insertNode(node.Right, interval, depth + 1);
%             end
%             
%             % 更新最大值
%             node.Max = max(node.Max, max(interval(:, 2)));
%         end
%         
%         function obj = delete(obj, interval)
%             obj.Root = obj.deleteNode(obj.Root, interval, 1);
%         end
%         
%         function node = deleteNode(obj, node, interval, depth)
%             if isempty(node)
%                 return;
%             end
%             
%             cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
%             
%             if isequal(node.Interval, interval)
%                 if isempty(node.Left)
%                     node = node.Right;
%                 elseif isempty(node.Right)
%                     node = node.Left;
%                 else
%                     temp = obj.findMin(node.Right, cd, depth + 1);
%                     node.Interval = temp.Interval;
%                     node.Right = obj.deleteNode(node.Right, temp.Interval, depth + 1);
%                 end
%             elseif interval(cd, 1) < node.Interval(cd, 1)
%                 node.Left = obj.deleteNode(node.Left, interval, depth + 1);
%             else
%                 node.Right = obj.deleteNode(node.Right, interval, depth + 1);
%             end
%             
%             if ~isempty(node)
%                 node.Max = max([node.Interval(:, 2); obj.getMax(node.Left); obj.getMax(node.Right)]);
%             end
%         end
%         
%         function maxVal = getMax(~, node)
%             if isempty(node)
%                 maxVal = -inf;
%             else
%                 maxVal = node.Max;
%             end
%         end
%         
%         function result = query(obj, interval)
%             result = obj.queryNode(obj.Root, interval, 1);
%         end
%         
%         function result = queryNode(obj, node, interval, depth)
%             if isempty(node)
%                 result = false;
%                 return;
%             end
%             
%             if obj.isOverlap(node.Interval, interval)
%                 result = true;
%                 return;
%             end
%             
%             cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
%             
%             if ~isempty(node.Left) && node.Left.Max >= interval(cd, 1)
%                 result = obj.queryNode(node.Left, interval, depth + 1);
%             else
%                 result = obj.queryNode(node.Right, interval, depth + 1);
%             end
%         end
%         
%         function bool = isOverlap(~, interval1, interval2)
%             bool = all(interval1(:, 1) <= interval2(:, 2) & interval2(:, 1) <= interval1(:, 2));
%         end
%         
%         function inorderTraversal(obj)
%             obj.inorder(obj.Root);
%         end
%         
%         function inorder(obj, node)
%             if isempty(node)
%                 return;
%             end
%             obj.inorder(node.Left);
%             disp(['Interval: [', num2str(node.Interval(:, 1)'), ', ', num2str(node.Interval(:, 2)'), '], Max: ', num2str(node.Max)]);
%             obj.inorder(node.Right);
%         end
%         
%         function node = findMin(obj, node, cd, depth)
%             if isempty(node)
%                 return;
%             end
%             
%             if mod(depth - 1, obj.Dimension) + 1 == cd
%                 if isempty(node.Left)
%                     return;
%                 end
%                 node = obj.findMin(node.Left, cd, depth + 1);
%             else
%                 leftMin = obj.findMin(node.Left, cd, depth + 1);
%                 rightMin = obj.findMin(node.Right, cd, depth + 1);
%                 minNode = node;
%                 
%                 if ~isempty(leftMin) && leftMin.Interval(cd, 1) < minNode.Interval(cd, 1)
%                     minNode = leftMin;
%                 end
%                 if ~isempty(rightMin) && rightMin.Interval(cd, 1) < minNode.Interval(cd, 1)
%                     minNode = rightMin;
%                 end
%                 node = minNode;
%             end
%         end
%         
%         function plotTree(obj)
%             figure;
%             hold on;
%             axis off;
%             obj.plotNode(obj.Root, 0.5, 1, 0.25, 1, 1);
%             hold off;
%         end
%         
%         function plotNode(obj, node, x, y, xOffset, yOffset, depth)
%             if isempty(node)
%                 return;
%             end
%             
%             plot(x, y, 'ko', 'MarkerFaceColor', 'k');
%             text(x, y, ['[', num2str(node.Interval(:, 1)'), ',', num2str(node.Interval(:, 2)'), '], Max: ', num2str(node.Max')], ...
%                 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
%             
%             cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
%             
%             if ~isempty(node.Left)
%                 plot([x, x - xOffset], [y, y - yOffset], 'k-');
%                 obj.plotNode(node.Left, x - xOffset, y - yOffset, xOffset * 0.5, yOffset, depth + 1);
%             end
%             
%             if ~isempty(node.Right)
%                 plot([x, x + xOffset], [y, y - yOffset], 'k-');
%                 obj.plotNode(node.Right, x + xOffset, y - yOffset, xOffset * 0.5, yOffset, depth + 1);
%             end
%         end
%     end
% end
% %%%%%%%%%%%%%%%%%%%% KD区间树 %%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%% KD区间树上进一步增加节点可行性信息 %%%%%%%%%%%%%%%%%%%%
% 使用例子：
% tree = IntervalTree(2, @algorithmA, 0.1);
% tree=tree.insert([1,2;4,5]);
% tree=tree.insert([2,3;6,7]);
% tree=tree.insert([4,5;10,11]);
% tree.query([2.5,2.6;6.5,6.6]);
% tree.findNode([2,3;6,7])
% tree2 = tree;
% tree = tree.pruneInfeasibleNodes();
% tree.inorderTraversal();
% tree.plotTree;
classdef IntervalTree
    properties
        Root = []
        Dimension % 维度数
        Algorithm % 验证约束条件的算法
        Tolerance % 最小区间大小
    end
    
    methods
        function obj = IntervalTree(dimension, algorithm, tolerance)
            if nargin > 0
                obj.Dimension = dimension;
                obj.Algorithm = algorithm;
                obj.Tolerance = tolerance;
            else
                obj.Dimension = 1;
                obj.Tolerance = 1e-2;
            end
        end
        
        function obj = insert(obj, interval)
            obj.Root = obj.insertNode(obj.Root, interval, 1);
        end
        
        function node = insertNode(obj, node, interval, depth)
            if isempty(node)
                isFeasible = obj.Algorithm((interval(:,1) + interval(:,2)) / 2);
                node = IntervalTreeNode(interval, isFeasible);
                return;
            end
            
            cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
            
            if interval(cd, 1) < node.Interval(cd, 1)
                node.Left = obj.insertNode(node.Left, interval, depth + 1);
            else
                node.Right = obj.insertNode(node.Right, interval, depth + 1);
            end
            
            node.Max = max([node.Max, max(interval, [], 2)], [], 2);
        end
        
        function obj = delete(obj, interval)
            obj.Root = obj.deleteNode(obj.Root, interval, 1);
        end
        
        function node = deleteNode(obj, node, interval, depth)
            if isempty(node)
                return;
            end
            
            cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
            
            if isequal(node.Interval, interval)
                if isempty(node.Left)
                    node = node.Right;
                elseif isempty(node.Right)
                    node = node.Left;
                else
                    temp = obj.findMin(node.Right, cd, depth + 1);
                    node.Interval = temp.Interval;
                    node.Right = obj.deleteNode(node.Right, temp.Interval, depth + 1);
                end
            elseif interval(cd, 1) < node.Interval(cd, 1)
                node.Left = obj.deleteNode(node.Left, interval, depth + 1);
            else
                node.Right = obj.deleteNode(node.Right, interval, depth + 1);
            end
            
            if ~isempty(node)
                node.Max = max([node.Interval(:, 2), obj.getMax(node.Left), obj.getMax(node.Right)], [], 2);
            end
        end
        
        function maxVal = getMax(obj, node)
            if isempty(node)
                maxVal = -inf(obj.Dimension, 1);  % 确保返回 2x1 的负无穷向量
            else
                maxVal = node.Max;
            end
        end

        function minVal = getMin(obj, node)
            if isempty(node)
                minVal = inf(obj.Dimension, 1);  % 确保返回 2x1 的无穷向量
            else
                minVal = node.Min;
            end
        end
        
        function result = query(obj, interval)
            result = obj.queryNode(obj.Root, interval, 1);
        end
        
        function result = queryNode(obj, node, interval, depth)
            if isempty(node)
                result = false;
                return;
            end
            
            if obj.isOverlap(node.Interval, interval)
                if node.IsFeasible
                    result = true;
                    return;
                end
            end
            
            cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
            
            if ~isempty(node.Left) && node.Left.Max(cd) >= interval(cd, 1)
                result = obj.queryNode(node.Left, interval, depth + 1);
                if result
                    return;
                end
            end
            
            result = obj.queryNode(node.Right, interval, depth + 1);
        end
        
        function bool = isOverlap(~, interval1, interval2)
            bool = all(interval1(:, 1) <= interval2(:, 2) & interval2(:, 1) <= interval1(:, 2));
        end
        
        function inorderTraversal(obj)
            obj.inorder(obj.Root, 1);
        end
        
        function inorder(obj, node, depth)
            if isempty(node)
                return;
            end
            obj.inorder(node.Left, depth + 1);
            disp(['Interval: [', num2str(node.Interval(:, 1)'), ', ', num2str(node.Interval(:, 2)'), '], Max: ', num2str(node.Max'), ' Min: ', num2str(node.Min') ,', Feasible: ', num2str(node.IsFeasible)]);
            obj.inorder(node.Right, depth + 1);
        end
        
        function node = findMin(obj, node, cd, depth)
            if isempty(node)
                return;
            end
            
            if mod(depth - 1, obj.Dimension) + 1 == cd
                if isempty(node.Left)
                    return;
                end
                node = obj.findMin(node.Left, cd, depth + 1);
                return;
            else
                leftMin = obj.findMin(node.Left, cd, depth + 1);
                rightMin = obj.findMin(node.Right, cd, depth + 1);
                minNode = node;
                
                if ~isempty(leftMin) && leftMin.Interval(cd, 1) < minNode.Interval(cd, 1)
                    minNode = leftMin;
                end
                if ~isempty(rightMin) && rightMin.Interval(cd, 1) < minNode.Interval(cd, 1)
                    minNode = rightMin;
                end
                node = minNode;
            end
        end
        
        function plotTree(obj)
            figure;
            hold on;
            axis off;
            obj.plotNode(obj.Root, 0.5, 1, 0.25, 1, 1);
            hold off;
        end
        
        function plotNode(obj, node, x, y, xOffset, yOffset, depth)
            if isempty(node)
                return;
            end
            
            plot(x, y, 'ko', 'MarkerFaceColor', 'k');
            text(x, y, ['[', num2str(node.Interval(:, 1)'), ',', num2str(node.Interval(:, 2)'), '], Max: ', num2str(node.Max'), ' Min: ', num2str(node.Min')], ...
                'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
            
            cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度
            
            if ~isempty(node.Left)
                plot([x, x - xOffset], [y, y - yOffset], 'k-');
                obj.plotNode(node.Left, x - xOffset, y - yOffset, xOffset * 0.5, yOffset, depth + 1);
            end
            
            if ~isempty(node.Right)
                plot([x, x + xOffset], [y, y - yOffset], 'k-');
                obj.plotNode(node.Right, x + xOffset, y - yOffset, xOffset * 0.5, yOffset, depth + 1);
            end
        end

        function obj = pruneInfeasibleNodes(obj)
            obj.Root = obj.pruneNode(obj.Root);
        end

        function node = pruneNode(obj, node)
            if isempty(node)
                return;
            end
            
            % 递归修剪左子树和右子树
            node.Left = obj.pruneNode(node.Left);
            node.Right = obj.pruneNode(node.Right);
            
            % 检查当前节点是否可行
            if ~obj.Algorithm((node.Interval(:,1) + node.Interval(:,2)) / 2)
                % 当前节点不可行，将其删除
                if isempty(node.Left)
                    node = node.Right;
                elseif isempty(node.Right)
                    node = node.Left;
                else
                    % 找到右子树中的最小节点替代当前节点
                    temp = obj.findMin(node.Right, 1, 1);
                    node.Interval = temp.Interval;
                    node.Right = obj.deleteNode(node.Right, temp.Interval, 1);
                end
            end
            
            % 更新当前节点的 Max 值
            if ~isempty(node)
                maxLeft = obj.getMax(node.Left);
                maxRight = obj.getMax(node.Right);
                node.Max = max([node.Interval(:, 2), maxLeft, maxRight], [], 2);
            end

            % 更新当前节点的 Min 值
            if ~isempty(node)
                minLeft = obj.getMin(node.Left);
                minRight = obj.getMin(node.Right);
                node.Min = min([node.Interval(:, 2), minLeft, minRight], [], 2);
            end
        end

        function node = findNode(obj, interval)
            node = obj.findNodeRecursively(obj.Root, interval, 1);
        end

        function node = findNodeRecursively(obj, currentNode, interval, depth)
            if isempty(currentNode)
                node = [];  % 找不到返回空
                return;
            end

            if isequal(currentNode.Interval, interval)
                node = currentNode;  % 找到节点
                return;
            end

            cd = mod(depth - 1, obj.Dimension) + 1; % 当前维度

            if interval(cd, 1) < currentNode.Interval(cd, 1)
                node = obj.findNodeRecursively(currentNode.Left, interval, depth + 1);
            else
                node = obj.findNodeRecursively(currentNode.Right, interval, depth + 1);
            end
        end
    end
end
% %%%%%%%%%%%%%%%%%%%% KD区间树上进一步增加节点可行性信息 %%%%%%%%%%%%%%%%%%%%
