function isIntersect = gjk_intersect(A, B)
    % 判断两个凸多面体是否发生体积重叠碰撞（点、边、面接触不算）
    % A, B: n×3 顶点数组
    max_iter = 50;
    d = randn(1, 3);
    d = d / norm(d);
    simplex = support(A, B, d);
    d = -simplex;

    for i = 1:max_iter
        new_point = support(A, B, d);

        if any(all(abs(simplex - new_point) < 1e-8, 2))
            isIntersect = false; return;
        end

        if dot(new_point, d) < 0
            isIntersect = false; return;
        end

        simplex(end+1, :) = new_point;
        if size(simplex, 1) > 4
            simplex = simplex(end-3:end, :);
        end

        [contains_origin, simplex, d] = update_simplex(simplex, d);
        if contains_origin
            isIntersect = true; return;
        end

        if norm(d) < 1e-8
            isIntersect = false; return;
        end
    end

    % 若 GJK 无法收敛，使用 EPA 距离判定
    isIntersect = epa_fallback(simplex);
end

function p = support(A, B, d)
    [~, ia] = max(A * d');
    [~, ib] = max(B * (-d'));
    p = A(ia, :) - B(ib, :);
end

function [contains_origin, simplex, d] = update_simplex(simplex, d)
    switch size(simplex, 1)
        case 2
            [contains_origin, simplex, d] = line_case(simplex, d);
        case 3
            [contains_origin, simplex, d] = triangle_case(simplex, d);
        case 4
            [contains_origin, simplex, d] = tetrahedron_case(simplex, d);
        otherwise
            contains_origin = false;
    end
end

function [contains_origin, simplex, d] = line_case(simplex, d)
    A = simplex(2,:); B = simplex(1,:);
    AB = B - A; AO = -A;
    if dot(AB, AO) > 0
        d = cross(cross(AB, AO), AB);
        simplex = [B; A];
    else
        d = AO;
        simplex = A;
    end
    contains_origin = false;
end

function [contains_origin, simplex, d] = triangle_case(simplex, d)
    A = simplex(3,:); B = simplex(2,:); C = simplex(1,:);
    AB = B - A; AC = C - A; AO = -A;
    ABC = cross(AB, AC);

    if dot(cross(ABC, AC), AO) > 0
        d = cross(cross(AC, AO), AC);
        simplex = [C; A];
    elseif dot(cross(AB, ABC), AO) > 0
        d = cross(cross(AB, AO), AB);
        simplex = [B; A];
    else
        if dot(ABC, AO) > 0
            d = ABC;
        else
            d = -ABC;
            simplex = [C; B; A];
        end
    end
    contains_origin = false;
end

function [contains_origin, simplex, d] = tetrahedron_case(simplex, d)
    A = simplex(4,:); B = simplex(3,:); C = simplex(2,:); D = simplex(1,:);
    AO = -A;
    ABC = cross(B - A, C - A);
    ACD = cross(C - A, D - A);
    ADB = cross(D - A, B - A);

    if dot(ABC, AO) > 0
        d = ABC;
        simplex = [C; B; A];
        contains_origin = false; return;
    end
    if dot(ACD, AO) > 0
        d = ACD;
        simplex = [D; C; A];
        contains_origin = false; return;
    end
    if dot(ADB, AO) > 0
        d = ADB;
        simplex = [B; D; A];
        contains_origin = false; return;
    end

    if point_in_tetrahedron_strict([0 0 0], A, B, C, D)
        contains_origin = true;
    else
        contains_origin = false;
    end
    d = [0 0 0];
end

function inside = point_in_tetrahedron_strict(p, A, B, C, D)
    eps = 1e-8;
    v0 = signed_volume(p, B, C, D);
    v1 = signed_volume(A, p, C, D);
    v2 = signed_volume(A, B, p, D);
    v3 = signed_volume(A, B, C, p);
    same_sign = all([v0 v1 v2 v3] > eps) || all([v0 v1 v2 v3] < -eps);
    inside = same_sign;
end

function vol = signed_volume(a, b, c, d)
    vol = dot(cross(b - a, c - a), d - a) / 6;
end

function result = epa_fallback(simplex)
    origin = [0 0 0];
    dists = vecnorm(simplex - origin, 2, 2);
    result = min(dists) < 1e-3;
end
