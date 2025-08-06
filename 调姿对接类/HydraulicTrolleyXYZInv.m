%%% function P = HydraulicTrolleyXYZInv(g0,g)
% ���ܣ� �������Һѹ�����˶�ѧ���
% ����1�� g0����λλ�ˣ�����ڳ�������ϵ{C}
% ����2�� g��Ŀ��λ�ˣ�����ڳ�������ϵ{C}
% ����� P��3 by 1��Ϊxyz����������͸׵��˶���
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-5-28
function P = HydraulicTrolleyXYZInv(g0,g)
dg = Vee(logm(pinv(g0)*g));
P = dg(4:6);
