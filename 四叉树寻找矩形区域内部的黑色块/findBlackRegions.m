function blackRegions = findBlackRegions(image)
    root = buildQuadtree(image);
    blackRegions = {};
    root.findBlackRegions(blackRegions);
end