% 时间：2024-9-22
% 功能：给一个灰度图像，根据灰度阈值进行4叉树分割，建立四叉树
% data = magic(20); % 使用魔方矩阵作为示例数据
ImpRgb=imread('D:\m_lib\四叉树图像自适应分割\Image.jpg');
data=rgb2gray(ImpRgb);
imshow(data);hold on;
yL=size(data,1);%地图y轴长度
xL=size(data,2);%地图x轴长度
% 构建四叉树
threshold = 50; % 设置阈值
root = buildQuadtree(data,[1,yL;1,xL], threshold);

% 遍历四叉树并打印每个叶节点的值
traverse(root, @plotRec);

function plotRec(index)
plot([index(2,1),index(2,1),index(2,2),index(2,2),index(2,1)],...
    [index(1,1),index(1,2),index(1,2),index(1,1),index(1,1)],'LineWidth',1);
end