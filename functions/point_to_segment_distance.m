% function d = point_to_segment_distance(point, segment_point1, segment_point2)
% 功能：计算点到线段的最短距离
% 输入1：点坐标
% 输入2：线段一个端点的坐标
% 输入3：线段另一个端点的坐标
% 输出：最短距离
function d = point_to_segment_distance(point, segment_point1, segment_point2)
    dim = max(size(point));
    if size(point,1) == 1
        point = point';
        segment_point1 = segment_point1';
        segment_point2 = segment_point2';
    end
    u = normS(segment_point2-segment_point1);
    p = point-segment_point1;
    if u'*p>norm(segment_point2-segment_point1)
        d = norm(p-segment_point2);
    elseif u'*p<0
        d = norm(p-segment_point1);
    else
        d = norm((eye(dim)-u*u')*p);
    end
end


