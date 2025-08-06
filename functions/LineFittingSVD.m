% ����lineData n*3����
% ���1 u0 ֱ�߷���
% ���2 p0 �㼯��ƽ��
function [u0,p0] = LineFittingSVD(lineData)
% ��ϵ�ֱ�߱ع��������������ƽ��ֵ
p0 = mean(lineData,1);

% Э�����������任�������ƽ�治ͬ����
% ����ֱ�ߵķ���ʵ�������������ֵ��Ӧ������������ͬ
centeredLine=bsxfun(@minus,lineData,p0);
[U,S,V]=svd(centeredLine);
u0=V(:,1);

% % ��ͼ
% t=-8:0.1:8;
% xx=p0(1)+u0(1)*t;
% yy=p0(2)+u0(2)*t;
% zz=p0(3)+u0(3)*t;
% plot3(xx,yy,zz)