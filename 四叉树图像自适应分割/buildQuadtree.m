function root = buildQuadtree(data,index, threshold)
    if isempty(data)
        root = [];
    elseif index(1,2)-index(1,1)<1 && index(2,2)-index(2,1)<1
        root.isLeaf = true;
        root.index = index;
    else
        root = createNode(data,index, false, [], [], [], []);
        if max(max(data(index(1,1):index(1,2),index(2,1):index(2,2)))) - min(min(data(index(1,1):index(1,2),index(2,1):index(2,2)))) > threshold
            % 数据的方差大于阈值，继续分割
            mid_y = floor((index(1,2)+index(1,1)) / 2);
            mid_x = floor((index(2,2)+index(2,1)) / 2);
            root.topLeft = buildQuadtree(data, [index(1,1),mid_y;index(2,1),mid_x], threshold);
            root.topRight = buildQuadtree(data, [index(1,1),mid_y;mid_x+1,index(2,2)], threshold);
            root.bottomLeft = buildQuadtree(data, [mid_y+1,index(1,2);index(2,1),mid_x], threshold);
            root.bottomRight = buildQuadtree(data, [mid_y+1,index(1,2);mid_x+1,index(2,2)], threshold);
        else
            % 数据的方差小于等于阈值，标记为叶节点
            root.isLeaf = true;
            root.index = index;
        end
    end
end