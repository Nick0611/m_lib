%%% TwoLineDist
% 作者 梁振鹍
% Date 2021-06-25
% 计算两直线距离
% 输入1 第一条直线6by1，前三个元素是方向，后三个元素是位置
% 输入2 第二条直线6by1，前三个元素是方向，后三个元素是位置
% 输出1 距离
% 输出2 第1条直线上的交点
% 输出3 第2条直线上的交点
% 输出4 公垂线方向向量

% Revision
% 2022-7-21
% 修改两直线平行时的函数输出提示
function varargout = TwoLineDist(ksi1,ksi2)
n1 = reshape(ksi1(1:3),3,1); p1 = reshape(ksi1(4:6),3,1);
n2 = reshape(ksi2(1:3),3,1); p2 = reshape(ksi2(4:6),3,1);
if norm(cross(n1,n2)) == 0 % 判断是否平行
    dis = sqrt(norm(p2-p1)^2-(n1'*(p2-p1))^2);
    disp('两条直线平行')  
    varargout{1} = dis;
    for i = 2:nargout
        varargout{i} = [];
    end
else
    nl = cross(n1,n2); nl =  nl/norm(nl); % 构造公垂线
    np = cross(nl,n1); np =  np/norm(np); % 构造公垂线和一条直线的平面
    lamda2 = -(np'*(p2-p1))/(np'*n2); % 计算另一条支线和平面的交点
    pcross2 = p2+lamda2*n2; % 第二条直线交点位置
    dis = abs(nl'*(pcross2-p1)); % 构造三角形计算垂线长度
    lamda1 = (n1'*(pcross2-p1))/(n1'*n1);
    pcross1 = p1+lamda1*n1; % 第一条直线交点位置
    varargout{1} = dis;
    varargout{2} = pcross1; % 第1条直线上的交点
    varargout{3} = pcross2; % 第2条直线上的交点
    varargout{4} = nl; % 公垂线方向向量
end
