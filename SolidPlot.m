%%% function CuboidPlot(lx,ly,lz,direct,theta,p,color)
% ���ܣ����Ƴ����壬����Ĭ������ϵԭ��Ϊ���ĵĹ�ؼ�����
% varargin{1}����ѡ����ƶ���
%
% case1 'cub' ���Ƴ�����
% ����2��������ĳ���ߵ����� 1 by 3
% ����3��direct �����᷽�� 3 by 1
% ����4��theta ��ת�ǶȻ�����
% ����5��p 3by1����ת֮���ٽ���ƽ��
% ����6֮�� ���ƻ��ƵĹؼ��ʣ����������Ӧ��ֵ��'FaceColor'/'FaceAlpha'/'EdgeColor'/'EdgeAlpha'/'LineWidth'/'LineStyle'/'Marker'
%
% case2 'sph' ��������
% ����2�� �뾶
% ����3�� Բ��λ�� 3 by 1
% ����4�� sphere(n)��ϸ�̶ֳ�n��һ���20
% ����5֮�� ���ƻ��ƵĹؼ��ʣ����������Ӧ��ֵ��ͬ��
% Revision 20230521
% �޸ĳ�����������ʽ������'�ؼ��ʿ���'�������ͼ�����������������Ѿ��޸Ĺ���
% Revision 20230602 https://zhuanlan.zhihu.com/p/61434972
%
% case 'ellipsoid' ���������� x^{T}Ax+x^{T}B=1����������������̻���������ϵ������������
% ����2�� A �Գ���������n by n��Bƽ������n by 1�� A = [1,2,0; 2,3,1; 0,1,1];
% ����3�� B
% ����4�� ����ϸ�̶ֳ�n��һ���20
% Revision-20231102 ��Բ�ĳ�����ֱ����ž���A���������������ķ���,��������֮��Ӧ������ֵ�ֱ��ǰ볤��Ͱ����ĳ��ȵ�ƽ���ĵ�����
% �޸Ļ������е�d = diag(D)Ϊd = 1./sqrt(diag(D))
% ���ӻ������е�view(3)
%
% Revision-20240414 ����'ellipsoid2'����Բ�İ볤�᲻ȡ������
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
% direct=[0 0 1];% direction��set as you will
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
        xCoor = {hr.XData};    % x����
        yCoor = {hr.YData};    % y����
        zCoor = {hr.ZData};    % z����
        x_new = cellfun(@(x,y)x+p(1),xCoor,'UniformOutput',false);    % x����ƽ��dx
        y_new = cellfun(@(x,y)x+p(2),yCoor,'UniformOutput',false);    % y����ƽ��dy
        z_new = cellfun(@(x,y)x+p(3),zCoor,'UniformOutput',false);    % z����ƽ��dz
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

            [V,D] = eig(A); % ��������ֵ�ĶԽǾ��� D �;��� V�������Ƕ�Ӧ��������������ʹ�� A*V = V*D��
            % ��V�е�ÿһ�п�����������ϵ�е�xyz�ᣬǰ���������������
            nd = size(A,1);
            d = 1./sqrt(diag(D));
            %R = R*(V+max(diag(V)/5)*eye(nd));
            %         %����������ͷ
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

            [V,D] = eig(A); % ��������ֵ�ĶԽǾ��� D �;��� V�������Ƕ�Ӧ��������������ʹ�� A*V = V*D��
            % ��V�е�ÿһ�п�����������ϵ�е�xyz�ᣬǰ���������������
            nd = size(A,1);
            d = sqrt(diag(D));
            %R = R*(V+max(diag(V)/5)*eye(nd));
            %         %����������ͷ
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
