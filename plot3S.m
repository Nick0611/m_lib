%%% plot3S
% data 2021-6-12
% input �������飬3*n������3*n*l
% ������Ϊ3*n������ÿһ��Ϊһ���������ͼ��һ�����߰���n���㣻
% ������Ϊ3*n*l������ÿһ��Ϊһ���������ͼ��һ�����߰���n���㣬һ��l�����ߣ�
% Revision
% Date 2021-6-21
% �ϸ����룬��������������ʾһ���㣻
% ���ӹ��ܣ���������3*n*l��һ�����߰���n���㣬һ��l�����ߣ�
% Revision
% Date 2023-4.7
% ����varargin{2:end}������ʹ��line�Ŀ�������
% Revision
% Date 2023-4.8
% ����plotҲ����plot3S
% Revision
% Date 2023-4.9
% ����1 by n�Ļ������������1:n
% Revision
% Date 2023-726
% varargin{2:end}�޸�Ϊvarargin{1:end}

function f = plot3S(points,varargin)
Mat = points;
[m,n,l] = size(Mat);
if m == 3
f = plot3(reshape(Mat(1,:,:),n,l),reshape(Mat(2,:,:),n,l),reshape(Mat(3,:,:),n,l),varargin{1:end});
end
if m == 2
    f = plot(reshape(Mat(1,:,:),n,l),reshape(Mat(2,:,:),n,l),varargin{1:end});
end
if m == 1
    f = plot(1:n,reshape(Mat(1,:,:),n,l),varargin{1:end});
end
