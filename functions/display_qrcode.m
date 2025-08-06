function display_qrcode(matrix)
    % 定义三种状态的颜色
    colors = {[241,223,164]/255, [166,205,228]/255, [116,182,159]/255}; % 黄色代表-1，蓝色代表0，绿色代表1
    
    % 获取矩阵的尺寸
    [m, n] = size(matrix);
    
    % 创建一个图形窗口
    figure;
    hold on;
    
    % 遍历矩阵中的每个元素，并根据其值绘制相应的方块
    for i = 1:m
        for j = 1:n
            % 根据矩阵中的值选择颜色
            color = colors{matrix(i, j) + 2}; % +2是因为矩阵中的值是-1, 0, 1
            
            % 绘制方块
            patch([j-0.5, j+0.5, j+0.5, j-0.5], [i-0.5, i-0.5, i+0.5, i+0.5], color, 'EdgeColor', 'none');
        end
    end
    
    % 设置图形属性
    axis equal tight;
    axis off; % 关闭坐标轴
    xlim([0.5, n + 0.5]);
    ylim([0.5, m + 0.5]);
%     title('Custom QR Code Display');
    hold off;
    set(gca, 'YDir', 'reverse');
end