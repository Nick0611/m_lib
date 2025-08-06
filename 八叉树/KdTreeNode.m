classdef KdTreeNode
    properties
        Data
        Left
        Right
    end
    
    methods
        function obj = KdTreeNode(data, k)
            obj.Data = data;
            obj.Left = [];
            obj.Right = [];
        end
    end
end