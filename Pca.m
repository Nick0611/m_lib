%%% 主成分分析Pca
% 输入1：按列构成的数据
% 输入2：主成分分析维数
% 输出1：主成分分析后的矩阵，在新基下面的新坐标
% 输出2：源数据矩阵均值，协方差矩阵的特征向量、奇异值构成的结构体
function [varargout] = Pca(varargin)
% X=[124.3000 134.7000 193.3000 118.6000 94.9000 123.8000
%     2.4200 2.5000 2.5600 2.5200 2.6000 2.6500
%     25.9800 21.0000 29.2600 31.1900 28.5600 28.1200
%     19.0000 19.2500 19.3100 19.3600 19.4500 19.6200
%     3.1000 3.3400 3.4500 3.5700 3.3900 3.5800
%     79.0000 84.0000 92.0000 105.0000 108.0000 108.0000
%     54.1000 53.7000 54.0000 53.9000 53.6000 53.3000
%     6.1400 6.7400 7.1800 8.2000 8.3400 8.5100
%     3.5700 3.5500 3.4000 3.2700 3.2000 3.1000
%     64.0000 64.9600 65.6500 67.0100 65.3400 66.9900]'; % 测试数据
% if nargin > 3 % 输入判断
%     for i = 4:nargin-1
%         switch varargin{i}
%             case 'color'
%                 color = varargin{i+1};
%             case 'text'
%                 text_flag = upper(varargin{i+1});
%             case 'fontsize'
%                 m_fontsize = varargin{i+1};
%             case 'linewidth'
%                 m_linewidth = varargin{i+1};
%         end
%     end
% end
X = varargin{1};%输入矩阵(列)
k=varargin{2};%维数
mapping.mean = mean(X, 1);% 输入数据的均值
X = X - repmat(mapping.mean, [size(X, 1) 1]);%去均值
C = cov(X);%协方差矩阵
C(isnan(C)) = 0;
C(isinf(C)) = 0;
[M, lambda] = eig(C);%求C矩阵特征向量及特征值
[lambda, ind] = sort(diag(lambda), 'descend');%排序降序
M = M(:,ind(1:k));%%取前k列
mappedX = X * M;%降维后的X
mapping.M = M;%映射的基
mapping.lambda = lambda;
if nargout == 1 || nargout == 0
    varargout{1} = mappedX;
end
if nargout == 2
    varargout{2} = mapping;
end

