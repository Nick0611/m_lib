%%% function P = HydraulicTrolleyXYZFor(g0,Drive)
% ���ܣ� �������Һѹ�����˶�ѧ���
% ����1�� g0����λλ��
% ����2�� Drive��3 by 1�������͸׵�������
% ����� P��3 by 1��Ϊ��ͷ��Գ�������ϵ{C}��λ��
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-5-28
function P = HydraulicTrolleyXYZFor(g0,Drive)
P = g0(1:3,4)+Drive;
