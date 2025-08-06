%%% function g = InterpolationLinear(g1,g2,t)
% ���ܣ� ����SE(3)�ؼ���֮����tλ�õĲ�ֵ��
% ����1�� λ�˹ؼ���1 4 by 4
% ����2�� λ�˹ؼ���2 4 by 4
% ����3�� ��ֵλ�� 0~1֮��
% ���1�� ��ֵ���ϵ�g 4 by 4 ����SE(3)
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-5-22
function g = InterpolationLinear(g1,g2,t) % �����ؼ���֮����tλ�õĲ�ֵ��
g = g1*expm(t*logm(pinv(g1)*g2));
