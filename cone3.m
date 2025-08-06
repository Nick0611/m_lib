%%% cone3绘制空间任意角度圆锥
% Version 1.0
% Data 2021-6-15
% 输入1 圆锥顶点坐标X1
% 输入2 圆锥底面圆心坐标X2
% 输入3 圆锥底面半径
% 输入4 'Plate' 可选参数 'y' 'n'，分别代表绘制底面和不绘制底面
% 可选输入5 'color',指定底面颜色
function cone3(varargin)
%%% 输入参数数量判断
if ~mod(nargin,2)
    fprintf("    Wrong input number!\n");
    return
end
X1 = varargin{1};
X2 = varargin{2};
r = varargin{3};
PlateFlag = 'n';
color = 'b';
if nargin > 3
    for i = 4:nargin-1
        switch lower(varargin{i})
            case 'plate'
                PlateFlag = lower(varargin{i+1});
            case 'color'
                color = varargin{i+1};
        end
    end
end
%一个简单的例子：cone3([1 2 3],[7 8 9],1,'b');%两个空间点位置，圆锥底面半径，颜色
% 圆锥的高度
length_cyl=norm(X2-X1);
[x,y,z]=cylinder(linspace(r,0,50),100);
z=z*length_cyl;
%绘制圆锥底面
hold on;
if(strcmp(PlateFlag,'y'))
    EndPlate1=fill3(x(1,:),y(1,:),z(1,:),color); % 填充底面
end
Cylinder=mesh(x,y,z); % 做圆锥侧面
%计算圆锥体旋转的角度
unit_V=[0 0 1];
angle_X1X2=acos(dot( unit_V,(X2-X1) )/( norm(unit_V)*norm(X2-X1)) )*180/pi;
%计算旋转轴
axis_rot=cross(unit_V,(X2-X1));
%将圆锥体旋转到期望方向
if angle_X1X2~=0 % Rotation is not needed if required direction is along X
    rotate(Cylinder,axis_rot,angle_X1X2,[0 0 0])
    if(strcmp(PlateFlag,'y'))
        rotate(EndPlate1,axis_rot,angle_X1X2,[0 0 0])
    end
end
%将圆锥体和底面挪到期望的位置
if(strcmp(PlateFlag,'y'))
    set(EndPlate1,'XData',get(EndPlate1,'XData')+X1(1))
    set(EndPlate1,'YData',get(EndPlate1,'YData')+X1(2))
    set(EndPlate1,'ZData',get(EndPlate1,'ZData')+X1(3))
end
set(Cylinder,'XData',get(Cylinder,'XData')+X1(1))
set(Cylinder,'YData',get(Cylinder,'YData')+X1(2))
set(Cylinder,'ZData',get(Cylinder,'ZData')+X1(3))
% 设置圆锥体的颜色
% set(Cylinder,'FaceColor',color)
% set(EndPlate1,'FaceColor',color)
% set(Cylinder,'EdgeAlpha',0.5)
% set(EndPlate1,'EdgeAlpha',0.5)
% axis equal;
view(3)
end
