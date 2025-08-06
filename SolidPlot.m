%%% function CuboidPlot(lx,ly,lz,direct,theta,p,color)
% 功能：绘制长方体，绘制默认坐标系原点为中心的规矩几何体
% varargin{1}用于选择绘制对象
%
% case1 'cub' 绘制长方体
% 输入2：长方体的长宽高的向量 1 by 3
% 输入3：direct 旋量轴方向 3 by 1
% 输入4：theta 旋转角度弧度制
% 输入5：p 3by1，旋转之后再进行平移
% 输入6之后： 控制绘制的关键词，后面跟着相应的值：'FaceColor'/'FaceAlpha'/'EdgeColor'/'EdgeAlpha'/'LineWidth'/'LineStyle'/'Marker'
%
% case2 'sph' 绘制球体
% 输入2： 半径
% 输入3： 圆心位置 3 by 1
% 输入4： sphere(n)的细分程度n，一般给20
% 输入5之后： 控制绘制的关键词，后面跟着相应的值，同上
% Revision 20230521
% 修改长方体的输入格式，增加'关键词控制'，并输出图像句柄，上述的输入已经修改过了
% Revision 20230602 https://zhuanlan.zhihu.com/p/61434972
%
% case 'ellipsoid' 绘制椭球体 x^{T}Ax+x^{T}B=1，用球坐标参数方程画，基坐标系就是特征向量
% 输入2： A 对称正定矩阵n by n，B平移向量n by 1， A = [1,2,0; 2,3,1; 0,1,1];
% 输入3： B
% 输入4： 网格细分程度n，一般给20
% Revision-20231102 椭圆的长短轴分别沿着矩阵A的两个特征向量的方向,而两个与之对应的特征值分别是半长轴和半短轴的长度的平方的倒数。
% 修改画椭球中的d = diag(D)为d = 1./sqrt(diag(D))
% 增加画椭球中的view(3)
%
% Revision-20240414 增加'ellipsoid2'，椭圆的半长轴不取倒数了
function varargout = SolidPlot(varargin)
% [x,y,z]=meshgrid([-1 1]);
% h=slice(x,y,z,z,[-1 1],[-1 1],[-1 1]);
% hold on
% hr=slice(x,y,z,z,[-1 1],[-1 1],[-1 1]);
% hold off
% col=jet(6);
% for i=1:length(h)
% set(h(i),'LineStyle','--','FaceAlpha',0.9,'FaceColor',col(mod(i-1,6)+1,:));
% set(hr(i),'FaceColor',col(mod(i-1,6)+1,:));
% end
% p=[2 1 0];% a point on the axis
% direct=[0 0 1];% direction，set as you will
% theta=pi/2;% rotation angle, set as you pleased
% rotate(hr,direct,rad2deg(theta),p)
% line([p(1) p(1)+direct(1)],[p(2) p(2)+direct(2)],[p(3) p(3)+direct(3)],'color','k','linewidth',2)
% line(p(1)+direct(1), p(2)+direct(2), p(3)+direct(3),'Marker','^','MarkerFace','k')
% axis equal
flag = 0;
switch varargin{1}
    case 'cub'
        [lx,ly,lz] = deal(varargin{2}(1),varargin{2}(2),varargin{2}(3));
        direct = varargin{3};theta = varargin{4};p = varargin{5};
        [x,y,z]=meshgrid([-lx/2 lx/2],[-ly/2 ly/2],[-lz/2,lz/2]);
        hr=slice(x,y,z,z,[-lx/2 lx/2],[-ly/2 ly/2],[-lz/2,lz/2]);
        if nargin>5
            flag = 1;
            num = 6;
        end
        rotate(hr,direct,rad2deg(theta),[0;0;0])
        xCoor = {hr.XData};    % x坐标
        yCoor = {hr.YData};    % y坐标
        zCoor = {hr.ZData};    % z坐标
        x_new = cellfun(@(x,y)x+p(1),xCoor,'UniformOutput',false);    % x坐标平移dx
        y_new = cellfun(@(x,y)x+p(2),yCoor,'UniformOutput',false);    % y坐标平移dy
        z_new = cellfun(@(x,y)x+p(3),zCoor,'UniformOutput',false);    % z坐标平移dz
        [hr.XData] = x_new{:};
        [hr.YData] = y_new{:};
        [hr.ZData] = z_new{:};
    case 'sph'
        r = varargin{2};p = varargin{3};n = varargin{4};
        [x,y,z] = sphere(n);
        x = r*x; y = r*y; z = r*z;
        hr = surf(x+p(1),y+p(2),z+p(3));
        if nargin>4
            flag = 1;
            num = 5;
        end
    case 'ellipsoid'
        [A,B] = deal(varargin{2},varargin{3});
        n = varargin{4};
        %         if issymmetric(A)
        d = eig(A);
        if all(d > 1e-6)
            [phi,theta] = meshgrid(linspace(0,360,n),linspace(0,180,n));
            [nr,nc] = size(phi);
            Phi = reshape(phi,nr*nc,1)*pi/180;
            Theta = reshape(theta,nr*nc,1)*pi/180;

            [V,D] = eig(A); % 返回特征值的对角矩阵 D 和矩阵 V，其列是对应的右特征向量，使得 A*V = V*D。
            % 将V中的每一列看成正规坐标系中的xyz轴，前面的坐标是球坐标
            nd = size(A,1);
            d = 1./sqrt(diag(D));
            %R = R*(V+max(diag(V)/5)*eye(nd));
            %         %绘制向量箭头
            %         arrow3(zeros(nd),R');
            xyz = d(1)*sin(Theta).*cos(Phi).*V(:,1)' + d(2)*sin(Theta).*sin(Phi).*V(:,2)' + d(3)*cos(Theta).*V(:,3)' ...
                + repmat((B)',nr*nc,1);
            P1 = reshape(xyz(:,1),nr,nc);
            P2 = reshape(xyz(:,2),nr,nc);
            P3 = reshape(xyz(:,3),nr,nc);
            hold on;
            hr = surf(P1, P2, P3);
            view(3);
            if nargin>4
                flag = 1;
                num = 5;
            end
        else
            disp('not positive definite matric!\n');
        end
        %         else
        %             disp('not symmetric matric!\n');
        %         end
    case 'ellipsoid2'
        [A,B] = deal(varargin{2},varargin{3});
        n = varargin{4};
        %         if issymmetric(A)
        d = eig(A);
        if all(d > 1e-6)
            [phi,theta] = meshgrid(linspace(0,360,n),linspace(0,180,n));
            [nr,nc] = size(phi);
            Phi = reshape(phi,nr*nc,1)*pi/180;
            Theta = reshape(theta,nr*nc,1)*pi/180;

            [V,D] = eig(A); % 返回特征值的对角矩阵 D 和矩阵 V，其列是对应的右特征向量，使得 A*V = V*D。
            % 将V中的每一列看成正规坐标系中的xyz轴，前面的坐标是球坐标
            nd = size(A,1);
            d = sqrt(diag(D));
            %R = R*(V+max(diag(V)/5)*eye(nd));
            %         %绘制向量箭头
            %         arrow3(zeros(nd),R');
            xyz = d(1)*sin(Theta).*cos(Phi).*V(:,1)' + d(2)*sin(Theta).*sin(Phi).*V(:,2)' + d(3)*cos(Theta).*V(:,3)' ...
                + repmat((B)',nr*nc,1);
            P1 = reshape(xyz(:,1),nr,nc);
            P2 = reshape(xyz(:,2),nr,nc);
            P3 = reshape(xyz(:,3),nr,nc);
            hold on;
            hr = surf(P1, P2, P3);
            view(3);
            if nargin>4
                flag = 1;
                num = 5;
            end
        else
            disp('not positive definite matric!\n');
        end
end
v = cell(1);
if flag
    v = varargin(num:end);
    while(size(v,2))
        switch lower(v{1})
            case 'facecolor'
                FaceColor = v{2};
                v(1:2) = [];
                [hr.FaceColor] = deal(FaceColor);
            case 'facealpha'
                FaceAlpha = v{2};
                v(1:2) = [];
                [hr.FaceAlpha] = deal(FaceAlpha);
            case 'edgecolor'
                EdgeColor = v{2};
                v(1:2) = [];
                [hr.EdgeAlpha] = deal(EdgeColor);
            case 'edgealpha'
                EdgeAlpha = v{2};
                v(1:2) = [];
                [hr.EdgeAlpha] = deal(EdgeAlpha);
            case 'linewidth'
                LineWidth = v{2};
                v(1:2) = [];
                [hr.EdgeAlpha] = deal(LineWidth);
            case 'linestyle'
                LineStyle = v{2};
                v(1:2) = [];
                [hr.EdgeAlpha] = deal(LineStyle);
            case 'marker'
                Marker = v{2};
                v(1:2) = [];
                [hr.EdgeAlpha] = deal(Marker);
            otherwise
                disp('Wrong input!\n')
                break;
        end
    end
end
varargout{1} = hr;
