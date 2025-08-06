function traverse(node, func)
    if node.isLeaf
        func(node.index);
    else
        traverse(node.topLeft, func);
        traverse(node.topRight, func);
        traverse(node.bottomLeft, func);
        traverse(node.bottomRight, func);
    end
end