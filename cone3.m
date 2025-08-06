%%% cone3���ƿռ�����Ƕ�Բ׶
% Version 1.0
% Data 2021-6-15
% ����1 Բ׶��������X1
% ����2 Բ׶����Բ������X2
% ����3 Բ׶����뾶
% ����4 'Plate' ��ѡ���� 'y' 'n'���ֱ������Ƶ���Ͳ����Ƶ���
% ��ѡ����5 'color',ָ��������ɫ
function cone3(varargin)
%%% ������������ж�
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
%һ���򵥵����ӣ�cone3([1 2 3],[7 8 9],1,'b');%�����ռ��λ�ã�Բ׶����뾶����ɫ
% Բ׶�ĸ߶�
length_cyl=norm(X2-X1);
[x,y,z]=cylinder(linspace(r,0,50),100);
z=z*length_cyl;
%����Բ׶����
hold on;
if(strcmp(PlateFlag,'y'))
    EndPlate1=fill3(x(1,:),y(1,:),z(1,:),color); % ������
end
Cylinder=mesh(x,y,z); % ��Բ׶����
%����Բ׶����ת�ĽǶ�
unit_V=[0 0 1];
angle_X1X2=acos(dot( unit_V,(X2-X1) )/( norm(unit_V)*norm(X2-X1)) )*180/pi;
%������ת��
axis_rot=cross(unit_V,(X2-X1));
%��Բ׶����ת����������
if angle_X1X2~=0 % Rotation is not needed if required direction is along X
    rotate(Cylinder,axis_rot,angle_X1X2,[0 0 0])
    if(strcmp(PlateFlag,'y'))
        rotate(EndPlate1,axis_rot,angle_X1X2,[0 0 0])
    end
end
%��Բ׶��͵���Ų��������λ��
if(strcmp(PlateFlag,'y'))
    set(EndPlate1,'XData',get(EndPlate1,'XData')+X1(1))
    set(EndPlate1,'YData',get(EndPlate1,'YData')+X1(2))
    set(EndPlate1,'ZData',get(EndPlate1,'ZData')+X1(3))
end
set(Cylinder,'XData',get(Cylinder,'XData')+X1(1))
set(Cylinder,'YData',get(Cylinder,'YData')+X1(2))
set(Cylinder,'ZData',get(Cylinder,'ZData')+X1(3))
% ����Բ׶�����ɫ
% set(Cylinder,'FaceColor',color)
% set(EndPlate1,'FaceColor',color)
% set(Cylinder,'EdgeAlpha',0.5)
% set(EndPlate1,'EdgeAlpha',0.5)
% axis equal;
view(3)
end
