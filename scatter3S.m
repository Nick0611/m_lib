%%% scatter3S
% data 2021-6-21
% input �������飬3*n
% ������Ϊ3*n������ÿһ��Ϊһ���������ͼ��
% Revision
% Date 2021-6-21
% �ϸ����룬��������������ʾһ����
% Revision
% Date 2022-7-15
% ��Բ�ͬά�ȵ��������룬�в�ͬ�ı��֣���varargin{2:end}�������Կ���

function f = scatter3S(varargin)
Mat = varargin{1};
[a,b] = size(Mat);
if a == b && b == 3
    disp("�����������У�Ĭ��ÿһ��Ϊһ��������ꡣ")
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
if a == b && b == 2
    disp("�����������У�Ĭ��ÿһ��Ϊһ��������ꡣ")
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 2 && b>3
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 3 && b>3
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
if b == 2 && a>3
    f = scatter(Mat(:,1),Mat(:,2),varargin{2:end});
    return
end
if b == 3 && a>3
    f = scatter3(Mat(:,1),Mat(:,2),Mat(:,3),varargin{2:end});
    return
end
if a == 2 && b==3
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 3 && b==2
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
if a == 1 && b==2
    f = scatter(Mat(:,1),Mat(:,2),varargin{2:end});
    return
end
if b == 1 && a==2
    f = scatter(Mat(1,:),Mat(2,:),varargin{2:end});
    return
end
if a == 1 && b==3
    f = scatter3(Mat(:,1),Mat(:,2),Mat(:,3),varargin{2:end});
    return
end
if b == 1 && a==3
    f = scatter3(Mat(1,:),Mat(2,:),Mat(3,:),varargin{2:end});
    return
end
disp('Wrong Input!')
