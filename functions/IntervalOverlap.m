% 功能：输出两个区间的重叠区间
% x1 = [1,6], x2 = [0,4]
% y = [1,4]
% x1 = [-Inf,0], x2 = [0,Inf]
% y = [0,0]
function y = IntervalOverlap(x1,x2)
if any(isnan(x1) | isnan(x2))
    y = [NaN,NaN];
else
    x1 = [min(x1),max(x1)];
    x2 = [min(x2),max(x2)];
    y(1) = max(x1(1),x2(1));
    y(2) = min(x1(2),x2(2));

    if y(1)>y(2)
        y = [NaN,NaN];
    end
end