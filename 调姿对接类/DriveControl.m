%%% function [Drive,gG] = DriveControl(g_OC,g0,gb,num_g,varargin)
    % ���ܣ� ����ÿ��С���������͸׵�������
    % ����1�� g_OC��ÿ��С������ϵ�����ȫ������ϵ����ϵ,1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
    % ����2�� g0��ÿ����ͷ����ϵ�ĳ�ʼλ�������С������ϵ,1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
    % ����3�� g_now��С����ͷ����ϵ��ǰλ�����С������ϵ��1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by
    % 4����ʱ��û����費��Ҫ���
    % ����4�� gb��ÿ����ͷ����ϵ����ڻ����������ϵ,1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
    % ����5�� num_g ��Ҫ����·���Ŀ��Ƶ������
    % ����6�� g1,g2,...,gnum_g �����������ϵ��;�о���λ�� 4 by 4������д��
    % ����7�� num_Interpolation ÿ�����ؼ���֮��Ĳ�ֵ�����������������յ㣬Ĭ��100
    % ����8�� ControlPointRatio������Bezier��ֵʱ�ؼ���������Ƶ���쳤�ʣ�Ĭ��0.2
    % [R1,g1] = T_Matrix(0,0,0,0,0,0,'z-y-x','Eular'); % ������������ϵ�ĵ�ǰλ��
    % [R2,g2] = T_Matrix(pi/24,pi/36,pi/24,20,6,10,'z-y-x','Eular');
    % [R3,g3] = T_Matrix(pi/12,pi/24,pi/12,30,18,16,'z-y-x','Eular'); % ������������ϵ��Ŀ��λ��
    % ���1�� Drive ÿ̨����ÿ��·�����µĸ����͸׵�������
    % ���2�� gG ÿ̨������ͷ��ȫ������ϵ�µ�ÿ��·�����϶�Ӧ��λ��
    % ���ߣ� Zachary Liang
    % ʱ�䣺 2023-6-4
    % Revision 20230727
    % ��ΪIntrplBezier���������˴���������3�ײ�ֵ��·������ʼ�����ֹ��϶�Ϊһ���������鳤�������޸�
function [Drive,gG] = DriveControl(g_OC,g0,g_now,gb,num_g,varargin)
num_trolley = size(g_OC,2);
num_Interpolation = 100;
ControlPointRatio = 0.2;
gB = {};
if nargin>num_g+5
    num_Interpolation = varargin{num_g+1};
end
if nargin>num_g+6
    ControlPointRatio = varargin{num_g+2};
end

% ·����ֵ
gg = IntrplBezier(ControlPointRatio,num_Interpolation,varargin{1:num_g}); % ��Ⱥ�켣��ֵ������Ĭ�������ؼ���֮���ֵ120����������β�ؼ���
for i = 1:num_g-1
gB = [gB,gg{i}]; % ������������ϵ�Ĳ�ֵ�㴦��λ��
end

% ����������
for i = 1:size(gB,2)
    for j = 1:num_trolley
        gG{i}{j} = gB{i}*gb{j}; % ����õ���С����ͷ��ȫ������ϵ�е�λ��
        Drive{i}{j} = HydraulicTrolleyXYZInv(g0{j},pinv(g_OC{j})*gG{i}{j}); % ��j�����ĵ�i���켣����˶�ѧ���
    end
%     DrawCoor(gcf,gB{i},1);
end
