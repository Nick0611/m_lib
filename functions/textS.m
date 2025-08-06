%%% textS
% data 2021-8-26
% author: Zachary Leung
% ��Բ�ͬά�ȵ��������룬�в�ͬ�ı��֣���varargin{2:end}�������Կ���
% revision 2023-3-28: ����ʹ��'text'������ʾ��Ҫ���ı�������Ϊͬ��ά�ȵ�Ԫ����ʽ

function f = textS(varargin)
Mat = varargin{1};
[a,b] = size(Mat);
m_text = num2cell(1:b);
v = varargin(2:end);
if nargin>1
    for i = 2:nargin-1
        if isscalar(varargin{i}) == 1 || ischar(varargin{i})
            switch varargin{i}
                case 'text'
                    m_text = varargin{i+1};
                    v(i-1:i) = [];
            end
        end
    end
end
if a == b && b == 3
%     disp("�����������У�Ĭ��ÿһ��Ϊһ��������ꡣ")
    f = text(Mat(1,:),Mat(2,:),Mat(3,:),m_text,v{1:end});
    return
end
if a == b && b == 2
%     disp("�����������У�Ĭ��ÿһ��Ϊһ��������ꡣ")
    f = text(Mat(1,:),Mat(2,:),m_text,v{1:end});
    return
end
if a == 2 && b>3
    f = text(Mat(1,:),Mat(2,:),m_text,v{1:end});
    return
end
if a == 3 && b>3
    f = text(Mat(1,:),Mat(2,:),Mat(3,:),m_text,v{1:end});
    return
end
if b == 2 && a>3
    f = text(Mat(:,1),Mat(:,2),num2cell(1:a),v{1:end});
    return
end
if b == 3 && a>3
    f = text(Mat(:,1),Mat(:,2),Mat(:,3),num2cell(1:a),v{1:end});
    return
end
if a == 2 && b==3
    f = text(Mat(1,:),Mat(2,:),m_text,v{1:end});
    return
end
if a == 3 && b==2
    f = text(Mat(1,:),Mat(2,:),Mat(3,:),m_text,v{1:end});
    return
end
if a == 1 && b==2
    f = text(Mat(:,1),Mat(:,2),num2cell(1:a),v{1:end});
    return
end
if b == 1 && a==2
    f = text(Mat(1,:),Mat(2,:),m_text,v{1:end});
    return
end
if a == 1 && b==3
    f = text(Mat(:,1),Mat(:,2),Mat(:,3),num2cell(1:a),v{1:end});
    return
end
if b == 1 && a==3
    f = text(Mat(1,:),Mat(2,:),Mat(3,:),m_text,v{1:end});
    return
end
% disp('Wrong Input!')
