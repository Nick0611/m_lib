classdef OctreeNode
    properties
        center % 节点中心点坐标
        size % 节点边长
        data % 存储在节点内的数据
        children % 子节点
    end
    
    methods
        % 构造函数
        function obj = OctreeNode(center, size)
            obj.center = center;
            obj.size = size;
            obj.data = [];
            obj.children = cell(1, 8);
        end
        
        % 插入数据到节点
        function obj = insertData(obj, data)
            obj.data = [obj.data; data];
        end
        
        % 创建子节点
        function obj = createChildren(obj)
            halfSize = obj.size / 2;
            for i = 1:8
                childCenter = obj.center + halfSize * OctreeNode.childOffset(i);
                obj.children{i} = OctreeNode(childCenter, halfSize);
            end
        end
    end
    
    methods (Static)
        % 计算子节点偏移量
        function offset = childOffset(index)
            offset = [ ...
                mod(index-1, 2), ... % x方向偏移量
                mod(floor((index-1)/2), 2), ... % y方向偏移量
                mod(floor((index-1)/4), 2) ... % z方向偏移量
            ] - 0.5; % 缩放到范围 [-0.5, 0.5]
        end
    end
end