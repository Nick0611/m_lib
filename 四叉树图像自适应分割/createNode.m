function Node = createNode(value,index, isLeaf, topLeft, topRight, bottomLeft, bottomRight)
    Node.value = value; % 节点值
    Node.index = index; % 节点值
    Node.isLeaf = isLeaf; % 是否是叶节点
    Node.topLeft = topLeft; % 左上子节点
    Node.topRight = topRight; % 右上子节点
    Node.bottomLeft = bottomLeft; % 左下子节点
    Node.bottomRight = bottomRight; % 右下子节点
end