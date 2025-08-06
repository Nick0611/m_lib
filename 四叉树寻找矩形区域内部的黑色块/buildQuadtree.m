function root = buildQuadtree(image)
    [height, width] = size(image);
    root = Node(0, 0, width, height, []);
    root.split(image);
end