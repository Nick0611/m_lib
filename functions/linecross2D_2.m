function vij = linecross2D_2(a1, b1, c1, a2, b2, c2)
    % 确定系数矩阵
    A = [a1, b1; a2, b2];
    % 确定常数向量
    C = -[c1; c2];
    
    % 计算行列式
    detA = det(A);
    
    if abs(detA) < eps % 行列式接近零，表示平行或重合，无交点或有无数个交点
        vij = [];
    else
        % 使用左除运算符 \ 求解线性方程组 Ax = C
        xy = A \ C;
        vij = [xy(1); xy(2)];
    end
end