% 功能：输出多个区间的重叠区间
% x = [1,6; 0,4; 2 7]
% y = [2,4]
function y = IntervalOverlapS(x)
n = size(x,1);
y = x(1,:);
for i = 2:n
    if any(isnan(y) | isnan(x(i,:)))
        y = [NaN,NaN];
    else
        x1 = [min(y),max(y)];
        x2 = [min(x(i,:)),max(x(i,:))];
        y(1) = max(x1(1),x2(1));
        y(2) = min(x1(2),x2(2));

        if y(1)>y(2)
            y = [NaN,NaN];
        end
    end
end