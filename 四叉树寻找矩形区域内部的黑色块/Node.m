classdef Node
    properties
        x
        y
        width
        height
        color
        children
    end

    methods
        function obj = Node(x, y, width, height, color)
            obj.x = x;
            obj.y = y;
            obj.width = width;
            obj.height = height;
            obj.color = color;
            obj.children = {};
        end

        function isLeaf = isLeaf(obj)
            isLeaf = isempty(obj.children);
        end

        function split(obj, image)
            if obj.isLeaf
                if obj.checkColor(image)
                    return;
                end
                halfWidth = floor(obj.width / 2);
                halfHeight = floor(obj.height / 2);
                obj.children = {
                    Node(obj.x, obj.y, halfWidth, halfHeight, []);
                    Node(obj.x + halfWidth, obj.y, halfWidth, halfHeight, []);
                    Node(obj.x, obj.y + halfHeight, halfWidth, halfHeight, []);
                    Node(obj.x + halfWidth, obj.y + halfHeight, halfWidth, halfHeight, [])
                };
                for i = 1:length(obj.children)
                    child = obj.children{i};
                    if isa(child, 'Node')
                        child.split(image);
                    else
                        error('Child is not a Node object');
                    end
                end
            end
        end

        function isConsistent = checkColor(obj, image)
            firstColor = image(obj.y + 1, obj.x + 1);
            for i = obj.y + 1 : obj.y + obj.height
                for j = obj.x + 1 : obj.x + obj.width
                    if image(i, j) ~= firstColor
                        isConsistent = false;
                        return;
                    end
                end
            end
            obj.color = firstColor;
            isConsistent = true;
        end

        function findBlackRegions(obj, blackRegions)
            if obj.isLeaf
                if obj.color == 0  % 假设黑色像素值为0
                    blackRegions{end+1} = [obj.x, obj.y, obj.width, obj.height];
                end
                return;
            end
            for i = 1:length(obj.children)
                child = obj.children{i};
                if isa(child, 'Node')
                    child.findBlackRegions(blackRegions);
                else
                    error('Child is not a Node object');
                end
            end
        end
    end
end