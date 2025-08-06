% revision2024-6-16：增加了bi和bj重合时的判断逻辑，如果ai和aj重合，则为0，否则为1。
% revision2024-7-16：ai和aj重合时也为0
% j相对于i
function y = TwoCableUpDownRelation(ai,bi,aj,bj,dis_min)
if isequal(bi,bj) && isequal(ai,aj)%绳索两端都重合
    y = 0;
    return;
elseif isequal(bi,bj) && (point_to_segment_distance(ai,bj,aj)<=dis_min || point_to_segment_distance(aj,bi,ai)<=dis_min) % 绳索B端重合，A端近似重合
    y = 0;
    return;
elseif isequal(ai,aj) && (point_to_segment_distance(bi,bj,aj)<=dis_min || point_to_segment_distance(bj,ai,bi)<=dis_min) % 绳索A端重合，B端近似重合
    y = 0;
    return;
elseif isequal(bi,bj) || isequal(ai,aj) % 只重合一端，那么需要检测1到0的变化来证明碰撞
    y = 1;
    return;
end

n = cross(ai-bj,bi-bj);
t = aj-bj;
flag = dot(n,t);
dis = TwoSegLineDist(ai,bi,aj,bj);

if flag>0
    y = 1;
elseif flag<0
    y = -1;
else
    y = 0;
end

if dis<=dis_min
    y = 0;
end