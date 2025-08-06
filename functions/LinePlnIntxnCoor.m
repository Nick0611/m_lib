
%% LinePlaneIntersectionCoordinate
% INPUT:
%   ����1��Plane's Init Coordinate before transformation [ex ey ez] 3 by
%   3����ʱĬ������λ�ô�[0;0;0]��ʼ
%   ������4 by 4����α任���󣬸�����ʼ���ߵ�λ�á�
%   ����2���ཻƽ���Transformation Matrix
%   ����3��generatrix's unit vector in World Coordinate������Ĭ�ϴӾֲ�����ϵ��ez���򷢳�
% OUTPUT:
%   r_store:Intersection ponits's 3-dim homogeneous coordinate
%   pl:generatrix's vector in World Coordinate

% Revision 2022-7-23
% ԭ�Ȱ汾Ĭ�ϼ��ⷢ�����ԭ�㣬����ԭ��Ҳ��Ҫ����
%%
function [varargout] = LinePlnIntxnCoor(varargin)
p_flag = 0; % �Ƿ�ͼ
p_state = 0; % �Ƿ񱣴�ͼ��
r0 = [0;0;0];
if isempty(varargin) || nargin~=3
    fprintf("     LinePlaneIntersectionCoordinate:\n");
    fprintf("        Error Input: Please input p0 n0 angle and gen!\n");
    if nargout >=1
        varargout{1} = 0;
    end
    if nargout >=2
        varargout{2} = 0; %
    end
    return;
end
if size(varargin{1},1)==3
    coor = varargin{1};
end
if size(varargin{1},1)==4
    coor = varargin{1}(1:3,1:3);
    r0 = varargin{1}(1:3,4);
end
T = varargin{2};
R = T(1:3,1:3);
p0 = T(1:3,4);
gen = varargin{3};
[ex_tar,ey_tar,ez_tar] = deal(T(1:3,1),T(1:3,2),T(1:3,3));
n0 = ez_tar;
total = size(gen,2);
[pl,l] = deal(zeros(3,total),zeros(total,1));
str = cell(1,total);
for num = 1:total
    l(num) = (p0-r0)'*n0/(gen(:,num)'*n0);
    pl(:,num) = l(num)*gen(:,num);
    r(:,num) = r0+pl(:,num);
    r_2dim(:,num) = T\[r(:,num);1];
    str{num} = num2str(num);
end


xfit = min(pl(1,:)):10:max(pl(1,:));
yfit = min(pl(2,:)):10:max(pl(2,:));
[XFIT,YFIT]= meshgrid (xfit,yfit);
d = -dot(n0,p0);
ZFIT = -(d + n0(1) * XFIT + n0(2) * YFIT)/n0(3);
C = 0.5*ones(size(XFIT,1),size(XFIT,2));

if p_flag
    figure('Name','LinePlaneINtersectionSimulation','Position',[0,0,1280,720])
    Path_str = 'buffer1\'; % ͼ��·��
    fig1 = mesh(XFIT,YFIT,ZFIT,C,'FaceAlpha',0.5);
    title("LinePlaneINtersectionSimulation")
    xlabel("x")
    ylabel("y")
    zlabel("z")
    axis manual
    hold on
    if p_state
        pict_name=['Intersection-',num2str(0)];
        F=getframe(gcf);
        imwrite(F.cdata, [Path_str,pict_name,'.png']);
    end
    axis equal
    % axis([-2*max(pl(1,:)) 2*max(pl(1,:)) -2*max(pl(2,:)) 2*max(pl(2,:)) 0 1.5*max(pl(3,:))])
    axis([-2*abs(p0(1)) 2*abs(p0(1)) -2*abs(p0(2)) 2*abs(p0(2)) 0 1.5*abs(p0(3))])
    xx_plot = [zeros(1,num);pl(1,:)];
    yy_plot = [zeros(1,num);pl(2,:)];
    zz_plot = [zeros(1,num);pl(3,:)];
    fig2 = plot3(xx_plot(:,1),yy_plot(:,1),zz_plot(:,1),'linewidth',2)
    for i=1:num
        set(fig2,'Xdata',xx_plot(:, i),'Ydata',yy_plot(:, i),'Zdata',zz_plot(:, i),'linewidth',2)
        if p_state
            pict_name=['Intersection-',num2str(i)];
            F=getframe(gcf);
            imwrite(F.cdata, [Path_str,pict_name,'.png']);
        end
    end
    grid on
    plot3(pl(1,:),pl(2,:),pl(3,:))
    text(pl(1,:),pl(2,:),pl(3,:),str,'fontsize',14);
    ex_plot = [[p0(1),p0(1),p0(1)];[p0(1),p0(1),p0(1)]+(max(pl(1,:))-min(pl(1,:)))*[ex_tar(1),ey_tar(1),ez_tar(1)]];
    ey_plot = [[p0(2),p0(2),p0(2)];[p0(2),p0(2),p0(2)]+(max(pl(1,:))-min(pl(1,:)))*[ex_tar(2),ey_tar(2),ez_tar(2)]];
    ez_plot = [[p0(3),p0(3),p0(3)];[p0(3),p0(3),p0(3)]+(max(pl(1,:))-min(pl(1,:)))*[ex_tar(3),ey_tar(3),ez_tar(3)]];
    plot3(ex_plot,ey_plot,ez_plot,'linewidth',2)
    set(gca,'linewidth',1.5,'fontsize',14,'fontname','Times');
    text((max(pl(1,:))-min(pl(1,:)))*E(1,:)+[p0(1),p0(1),p0(1)], ...,
        (max(pl(1,:))-min(pl(1,:)))*E(2,:)+[p0(2),p0(2),p0(2)], ...,
        (max(pl(1,:))-min(pl(1,:)))*E(3,:)+[p0(3),p0(3),p0(3)], ...,
        {"x","y","z"},'fontsize',14)
    if p_state
        pict_name=['Intersection-',num2str(num+1)];
        F=getframe(gcf);
        imwrite(F.cdata, [Path_str,pict_name,'.png']);
    end
end
if nargout >=1
    varargout{1} = r_2dim(1:2,:);
end
if nargout >=2
    varargout{2} = r;
end
if nargout >=3
    varargout{3} = l; %���ⳤ��
end

