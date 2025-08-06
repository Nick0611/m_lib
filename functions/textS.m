%%% textS
% data 2021-8-26
% author: Zachary Leung
% 针对不同维度的数组输入，有不同的表现；用varargin{2:end}增加属性控制
% revision 2023-3-28: 可以使用'text'控制显示想要的文本，输入为同等维度的元胞形式

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
%     disp("输入三行三列，默认每一列为一个点的坐标。")
    f = text(Mat(1,:),Mat(2,:),Mat(3,:),m_text,v{1:end});
    return
end
if a == b && b == 2
%     disp("输入两行两列，默认每一列为一个点的坐标。")
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
