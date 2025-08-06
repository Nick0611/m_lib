% 输入1：map，n*n各矩阵，i行j列的值是i和j节点的距离，不连接的用Inf，自身和自身用0
% 输入2：startingpoint，起始节点序号
% 输出1：distances，起始节点和所有节点的最短距离的数组n by 1
% 输出2：path，起始节点到其他节点的最短路径，但是还有问题，没解决
% 时间：2024-8-27
% 作者：Zachary Liang
% 来源：https://www.youtube.com/watch?v=otJAMukL3Iw&t=685s
% Note：有问题的，正确率不是100%
% 还是matlab自带的graph好用
function [distances,path] = Dijkstra(map,startingpoint)

% 节点的数量
N = length(map);

% 初始化所有距离为Inf
distances(1:N) = Inf;
path = cell(1,N);

% 标记所节点为未访问
visited(1:N) = 0;

% 初始化到第一个点的距离为0
distances(startingpoint) = 0;
for i = 1:N
    path{i} = startingpoint;
end

% 找到没有访问过的距离最小的节点，使之为当前节点，新距离为到所有它的相邻点的距离，如果更小则更新这个距离，并标记其为已访问
while sum(visited) < N
    candidates(1:N) = Inf;
    for index = 1:N
        if visited(index) == 0
            candidates(index) = distances(index);
        end
    end
    [currentDistance,currentPoint] = min(candidates);

    for index = 1:N
        newDistance = currentDistance+map(currentPoint,index);
        if newDistance<distances(index)
            distances(index) = newDistance;
            path{index}(end+1) = index;
        end
    end
    visited(currentPoint) = 1;
end
