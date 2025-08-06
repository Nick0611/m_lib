% revision2024-6-16修改4的判定条件，增加Ai和PAj重合的情况也归类为4，也就是(l(1)>0 && l(1)<1) &&
% (l(2)>0 && l(2)<1)修改为(l(1)>=0 && l(1)<=1) && (l(2)>=0 && l(2)<1)
% revision-2024-6-16增加了bi和bj重合时的判断逻辑，如果ai和aj重合，则为0，对应的位置关系为0，否则交叉状态也为0，但是对应的位置关系为1
% revision-2024-6-16增加两个绳索不重合但是平行的情况判断，原先会不一定判定属于哪种state，现在规定其属于9或者7
% revision-2024-7-16将ai == aj时y=2修改为y=0
% j相对于i
function y = TwoCableTopoRelation(ai,bi,aj,bj)
if isequal(bi,bj) % 锚点重合则为0
    y = 0;
    return;
end
% 判断两个绳索是否平行 %
c1 = ai-bi;
c2 = aj-bj;
if all(cross(c1,c2)==[0;0;0])
    idx = find(c1);
    if c1(idx(1))/c2(idx(1))>0
        y = 9;
    else
        y = 7;
    end
    return;
end
% 判断两个绳索是否平行 %
if isequal(ai,aj) % 出绳点重合则为2
    y = 0;
    return;
end

tmp = cross(ai-bj,bi-bj);
if sum(tmp == [0;0;0]) ~= 3
    n = normS(tmp);
else
    y = 0;
    return;
end
aj_P = (eye(3)-n*n')*(aj-bj)+bj;
ui = ai-bi;
uj = aj_P-bj;
U = [ui,-uj];
A = ai-aj_P;
l = pinv(U)*A;

% if l(1)>0 && l(1)<1 && l(2)>0 && l(2)<1
%     y = 1;
% elseif (l(1)<0 || l(1)>1) && (l(2)<0 || l(2)>1)
%     y = -1;
% else
%     y = 0;
% end

if (l(1)>0 && l(1)<1) && (l(2)<0)
    y = 1;
elseif (l(1)<0) && (l(2)<0)
    y = 2;
elseif (l(1)<0) && (l(2)>0 && l(2)<1)
    y = 3;
elseif (l(1)>=0 && l(1)<=1) && (l(2)>=0 && l(2)<1)
    y = 4;
elseif (l(1)>1) && (l(2)>0 && l(2)<1)
    y = 5;
elseif (l(1)>1) && (l(2)<0)
    y = 6;
elseif (l(1)<0) && (l(2)>1)
    y = 7;
elseif (l(1)>0 && l(1)<1) && (l(2)>1)
    y = 8;
elseif (l(1)>1) && (l(2)>1)
    y = 9;
else
    y = 0;
end