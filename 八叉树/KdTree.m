% kdTree也是一个二叉树，只不过其数据维度是k维的
% 第一层是通过比较数据的第一个维度，第二层是比较第二个维度，第k层是比较第k个维度，从而确定左分支还是右分支
% 时间：2024-7-16
% 来源：ChatGpt
%
% 使用例子：
% % 创建 k 维树对象，k=2 表示二叉树
% tree = KdTree(2);
% 
% % 插入数据（二维数据）
% tree = tree.insert([5, 3]);
% tree = tree.insert([2, 4]);
% tree = tree.insert([9, 6]);
% tree = tree.insert([4, 7]);
% tree = tree.insert([8, 1]);
% 
% % 查看树的中序遍历
% disp('Inorder traversal:');
% tree.inorder();
% 
% % 查看树的前序遍历
% disp('Preorder traversal:');
% tree.preorder();
% 
% % 查看树的后序遍历
% disp('Postorder traversal:');
% tree.postorder();
% 
% % 绘制树
% tree.plotTree();

classdef KdTree
    properties
        Root
        K
    end
    
    methods
        function obj = KdTree(k)
            if nargin > 0
                obj.K = k;
                obj.Root = [];
            end
        end
        
        function obj = insert(obj, data)
            newNode = KdTreeNode(data, obj.K);
            if isempty(obj.Root)
                obj.Root = newNode;
            else
                obj.Root = insertNode(obj.Root, newNode, 1, obj.K);
            end
        end
        
        function inorder(obj)
            if ~isempty(obj.Root)
                inorderTraversal(obj.Root);
            end
        end
        
        function preorder(obj)
            if ~isempty(obj.Root)
                preorderTraversal(obj.Root);
            end
        end
        
        function postorder(obj)
            if ~isempty(obj.Root)
                postorderTraversal(obj.Root);
            end
        end

        function plotTree(obj)
            if ~isempty(obj.Root)
                figure;
                hold on;
                axis off;
                plotNode(obj.Root, 0.5, 1, 0.25, 1);
                hold off;
            end
        end
    end
end

function root = insertNode(root, newNode, depth, k) % 分成两个函数insert和insertNode是因为外部使用的时候，直接insert(data)，而不会指定depth，深度用来确定数据比较的维度
    dim = mod(depth - 1, k) + 1;  % Calculate current dimension
    if newNode.Data(dim) < root.Data(dim)
        if isempty(root.Left)
            root.Left = newNode;
        else
            root.Left = insertNode(root.Left, newNode, depth + 1, k);
        end
    else
        if isempty(root.Right)
            root.Right = newNode;
        else
            root.Right = insertNode(root.Right, newNode, depth + 1, k);
        end
    end
end

function inorderTraversal(node)
    if ~isempty(node)
        inorderTraversal(node.Left);
        disp(node.Data);
        inorderTraversal(node.Right);
    end
end

function preorderTraversal(node)
    if ~isempty(node)
        disp(node.Data);
        preorderTraversal(node.Left);
        preorderTraversal(node.Right);
    end
end

function postorderTraversal(node)
    if ~isempty(node)
        postorderTraversal(node.Left);
        postorderTraversal(node.Right);
        disp(node.Data);
    end
end

function plotNode(node, x, y, xOffset, depth)
    if ~isempty(node)
        plot(x, y, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
        text(x, y, sprintf('(%d, %d)', node.Data(1), node.Data(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
        if ~isempty(node.Left)
            line([x, x - xOffset], [y, y - 1/depth], 'Color', 'k');
            plotNode(node.Left, x - xOffset, y - 1/depth, xOffset/2, depth + 1);
        end
        if ~isempty(node.Right)
            line([x, x + xOffset], [y, y - 1/depth], 'Color', 'k');
            plotNode(node.Right, x + xOffset, y - 1/depth, xOffset/2, depth + 1);
        end
    end
end
