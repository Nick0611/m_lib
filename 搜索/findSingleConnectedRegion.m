% 三维空间中用meshgrid生成一个点阵网格，比如说101010的网格，然后定义一个三维的体数据矩阵A，
% 维度跟这个网格重合，他的每一个元素是0或者1,1代表可行，0代表不可行，
% 0和1是通过某种程序计算出来的。假设A(i，j，k)的值为1，我想找到(i，j，k)附近的单连通区域，
% 也就是说这个区域内A的值都是1，这个区域之外的临近的值是0，当然，可能存在多个连通的区域，
% 但是我只关心(i，j，k)附近的单连通区域。怎么把这个区域求出来
%
% revision 2024-7-2
% 增加varargin选项，原先的程序只要某个方向有连接，就添加到队列，现在必须所有方向都连接，才能添加到队列
% 'mode1'/'mode2'

function connectedRegion = findSingleConnectedRegion(A, i, j, k,varargin)
mode = 1;
if nargin > 4
    if strcmp(varargin{1},'mode1')
        mode = 1;
    elseif strcmp(varargin{1},'mode2')
        mode = 2;
    end
end

% 确保(i, j, k)是可行区域
if A(i, j, k) == 0
    error('The given point is not in a feasible region.');
end

% 初始化
[m, n, p] = size(A);
connectedRegion = zeros(m, n, p);
visited = false(m, n, p);

% 6连通方向
directions = [-1, 0, 0; 1, 0, 0; 0, -1, 0; 0, 1, 0; 0, 0, -1; 0, 0, 1];

%     % 26连通方向
%     directions = [];
%     for dx = -1:1
%         for dy = -1:1
%             for dz = -1:1
%                 if dx ~= 0 || dy ~= 0 || dz ~= 0
%                     directions = [directions; dx, dy, dz];
%                 end
%             end
%         end
%     end

% 创建队列并加入起始点
queue = [i, j, k];
connectedRegion(i, j, k) = 1;
visited(i, j, k) = true;

while ~isempty(queue)
    % 从队列中取出一个点
    point = queue(1, :);
    queue(1, :) = [];

    % 遍历所有方向
    for d = 1:size(directions, 1)
        ni = point(1) + directions(d, 1);
        nj = point(2) + directions(d, 2);
        nk = point(3) + directions(d, 3);

        % 检查新点是否在矩阵范围内并且是未访问过的可行区域
        switch mode
            case 1
                if ni > 0 && ni <= m && nj > 0 && nj <= n && nk > 0 && nk <= p && ...
                        A(ni, nj, nk) == 1 && ~visited(ni, nj, nk)
                    % 标记为已访问
                    visited(ni, nj, nk) = true;
                    % 将新点加入队列
                    queue(end + 1, :) = [ni, nj, nk];
                    % 将新点标记为连通区域的一部分
                    connectedRegion(ni, nj, nk) = 1;
                end
            case 2
                if ni > 0 && ni <= m && nj > 0 && nj <= n && nk > 0 && nk <= p && ...
                        ~visited(ni, nj, nk) && isFeasible(A, ni, nj, nk)
                    % 标记为已访问
                    visited(ni, nj, nk) = true;
                    % 将新点加入队列
                    queue(end + 1, :) = [ni, nj, nk];
                    % 将新点标记为连通区域的一部分
                    connectedRegion(ni, nj, nk) = 1;
                end
        end  
    end
end

    function feasible = isFeasible(A2, i2, j2, k2)
        % 6连通方向
        directions2 = [-1, 0, 0; 1, 0, 0; 0, -1, 0; 0, 1, 0; 0, 0, -1; 0, 0, 1];
        [m2, n2, p2] = size(A2);
        feasible = true;

        % 检查中心点是否为1
        if A2(i2, j2, k2) == 0
            feasible = false;
            return;
        end

        % 检查六个方向是否都是1
        for d2 = 1:size(directions2, 1)
            ni2 = i2 + directions2(d2, 1);
            nj2 = j2 + directions2(d2, 2);
            nk2 = k2 + directions2(d2, 3);
            if ni2 <= 0 || ni2 > m2 || nj2 <= 0 || nj2 > n2 || nk2 <= 0 || nk2 > p2 || A2(ni2, nj2, nk2) == 0
                feasible = false;
                return;
            end
        end
    end
end
