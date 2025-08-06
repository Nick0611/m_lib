classdef Octree
    properties
        root % 根节点
    end
    
    methods
        % 构造函数
        function obj = Octree(center, size)
            obj.root = OctreeNode(center, size);
        end
        
        % 插入数据到八叉树
        function obj = insert(obj, data)
            obj.root = obj.insertRecursive(obj.root, data);
        end
        
        % 递归插入数据
        function node = insertRecursive(obj, node, data)
            % 判断数据是否在当前节点范围内
            if any(abs(data - node.center) > node.size / 2)
                return; % 数据不在当前节点范围内，不插入
            end
            
            % 如果节点还没有子节点，则将数据插入到当前节点中，并创建子节点
            if isempty(node.children{1})
                node = node.insertData(data);
                node.createChildren();
            else
                % 否则递归地插入到子节点中
                for i = 1:8
                    node.children{i} = obj.insertRecursive(node.children{i}, data);
                end
            end
        end
    end
end