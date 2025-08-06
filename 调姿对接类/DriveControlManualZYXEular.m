%%% function [Drive,gG] = DriveControlManualZYXEular(ax,ay,az,x,y,z,g_OC,g0,g_now,gb)
% ����1�� ZYX˳���������x��ת�ǣ�������
% ����2�� ZYX˳���������y��ת�ǣ�������
% ����3�� ZYX˳���������z��ת�ǣ�������
% ����4�� Ŀ��x
% ����5�� Ŀ��y
% ����6�� Ŀ��z
% ����7�� g_OC��ÿ��С������ϵ�����ȫ������ϵ����ϵ,1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
% ����8�� g0��ÿ����ͷ����ϵ�ĳ�ʼλ�������С������ϵ,1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
% ����9�� g_now��С����ͷ����ϵ��ǰλ�����С������ϵ��1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
% ����10�� gb��ÿ����ͷ����ϵ����ڻ����������ϵ,1 by num_trolley��Ԫ����ÿ��Ԫ��Ԫ����4 by 4
% ���1�� Drive ÿ̨����ÿ��·�����µĸ����͸׵�������
% ���2�� gG ÿ̨������ͷ��ȫ������ϵ�µ�ÿ��·�����϶�Ӧ��λ��
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-6-5
function [Drive,gG] = DriveControlManualZYXEular(ax,ay,az,x,y,z,g_OC,g0,g_now,gb)
[R,g] = T_Matrix(ax,ay,az,x,y,z);
    
num_trolley = size(g_OC,2);
num_Interpolation = 100;
ControlPointRatio = 0.2;
gB = {};

% ·����ֵ
gg = IntrplBezier(ControlPointRatio,num_Interpolation,eye(4),g); % ��Ⱥ�켣��ֵ������Ĭ�������ؼ���֮���ֵ120����������β�ؼ���
gB = [gg{1}];

% ����������
for i = 1:num_Interpolation
    for j = 1:num_trolley
        gG{i}{j} = gB{i}*gb{j}; % ����õ���С����ͷ��ȫ������ϵ�е�λ��
        Drive{i}{j} = HydraulicTrolleyXYZInv(g0{j},pinv(g_OC{j})*gG{i}{j}); % ��j�����ĵ�i���켣����˶�ѧ���
    end
%     DrawCoor(gcf,gB{i},1);
end

% ������Һѹ���ڱ�����ԭ������ϵ�еľ���ֵ
for j = 1:num_trolley
    for i = 1:100
        Drive{i}{j} = Drive{i}{j}+g_now{j}(1:3,4); % ���ϴ�ʱ�ı���������ֵ
    end
end
1;