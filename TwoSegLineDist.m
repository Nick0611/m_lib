%%% TwoSegLineDist
% 说明：分两大类，一、平行或共线，根据相对位置各分为9类；二、不平行不共线，分四小类。https://blog.csdn.net/weixin_43274035/article/details/104778342
% 作者 梁振鹍
% Date 2024-04-08
% 计算两线段的最近距离
% 输入1 A1，线段1的终点
% 输入2 B1，线段1的起点
% 输入3 A2，线段2的终点
% 输入4 B2，线段2的起点
% 输出1 距离
% 输出2 第1条直线上的交点
% 输出3 第2条直线上的交点
% 输出4 公垂线方向向量

function varargout = TwoSegLineDist(A1,B1,A2,B2)
n1 = normS(A1-B1); p1 = B1;
n2 = normS(A2-B2); p2 = B2;
if norm(cross(n1,n2)) == 0 % 判断是否平行
    dis = sqrt(norm(p2-p1)^2-(n1'*(p2-p1))^2);
    if dis>0 % 分成9类
%         disp('两条线段平行');
        if n1'*(A2-p1)>norm(A1-B1) && n1'*(B2-p1)>norm(A1-B1)
            [varargout{1},varargout{2},varargout{3},varargout{4}] = distance(A1,B1,A2,B2);
        elseif (n1'*(A2-p1)<=norm(A1-B1) && n1'*(A2-p1)>=0) && (n1'*(B2-p1)>norm(A1-B1))
            varargout{1} = dis;
            varargout{2} = A1;
            lam1 = n2'*(A1-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        elseif (n1'*(A2-p1)<=norm(A1-B1) && n1'*(A2-p1)>=0) && (n1'*(B2-p1)<=norm(A1-B1) && n1'*(B2-p1)>=0)
            varargout{1} = dis;
            varargout{2} = A2;
            lam1 = n2'*(A2-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        elseif n1'*(A2-p1)<0 && n1'*(B2-p1)>norm(A1-B1)
            varargout{1} = dis;
            varargout{2} = A1;
            lam1 = n2'*(A1-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        elseif n1'*(A2-p1)<0 && (n1'*(B2-p1)<=norm(A1-B1) && n1'*(B2-p1)>=0)
            varargout{1} = dis;
            varargout{2} = B1;
            lam1 = n2'*(B1-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        elseif n1'*(A2-p1)<0 && n1'*(B2-p1)<0
            [varargout{1},varargout{2},varargout{3},varargout{4}] = distance(A1,B1,A2,B2);
        elseif n1'*(A2-p1)>norm(A1-B1) && (n1'*(B2-p1)<=norm(A1-B1) && n1'*(B2-p1)>=0)
            varargout{1} = dis;
            varargout{2} = A1;
            lam1 = n2'*(A1-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        elseif (n1'*(A2-p1)<=norm(A1-B1) && n1'*(A2-p1)>=0) && n1'*(B2-p1)<0
            varargout{1} = dis;
            varargout{2} = B1;
            lam1 = n2'*(B1-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        elseif n1'*(A2-p1)>norm(A1-B1) && n1'*(B2-p1)<0
            varargout{1} = dis;
            varargout{2} = A1;
            lam1 = n2'*(A1-p2);
            varargout{3} = p2+lam1*n2;
            varargout{4} = normS(p2+lam1*n2-A1);
        end
    else
%         disp('两条线段共线');
        if n1'*(A2-p1)>norm(A1-B1) && n1'*(B2-p1)>norm(A1-B1)
            [varargout{1},varargout{2},varargout{3},varargout{4}] = distance(A1,B1,A2,B2);
        elseif (n1'*(A2-p1)<=norm(A1-B1) && n1'*(A2-p1)>=0) && (n1'*(B2-p1)>norm(A1-B1))
            varargout{1} = 0;
            varargout{2} = A1;
            varargout{3} = A2;
            varargout{4} = n1;
        elseif (n1'*(A2-p1)<=norm(A1-B1) && n1'*(A2-p1)>=0) && (n1'*(B2-p1)<=norm(A1-B1) && n1'*(B2-p1)>=0)
            varargout{1} = 0;
            varargout{2} = A2;
            varargout{3} = B2;
            varargout{4} = n1;
        elseif n1'*(A2-p1)<0 && n1'*(B2-p1)>norm(A1-B1)
            varargout{1} = 0;
            varargout{2} = A1;
            varargout{3} = B1;
            varargout{4} = n1;
        elseif n1'*(A2-p1)<0 && (n1'*(B2-p1)<=norm(A1-B1) && n1'*(B2-p1)>=0)
            varargout{1} = 0;
            varargout{2} = B1;
            varargout{3} = B2;
            varargout{4} = n1;
        elseif n1'*(A2-p1)<0 && n1'*(B2-p1)<0
            [varargout{1},varargout{2},varargout{3},varargout{4}] = distance(A1,B1,A2,B2);
        elseif n1'*(A2-p1)>norm(A1-B1) && (n1'*(B2-p1)<=norm(A1-B1) && n1'*(B2-p1)>=0)
            varargout{1} = 0;
            varargout{2} = A1;
            varargout{3} = B2;
            varargout{4} = n1;
        elseif (n1'*(A2-p1)<=norm(A1-B1) && n1'*(A2-p1)>=0) && n1'*(B2-p1)<0
            varargout{1} = 0;
            varargout{2} = B1;
            varargout{3} = A2;
            varargout{4} = n1;
        elseif n1'*(A2-p1)>norm(A1-B1) && n1'*(B2-p1)<0
            varargout{1} = 0;
            varargout{2} = A1;
            varargout{3} = B1;
            varargout{4} = n1;
        end
    end

else
    nl = cross(n1,n2); nl =  nl/norm(nl); % 构造公垂线
    np = cross(nl,n1); np =  np/norm(np); % 构造公垂线和一条直线的平面
    lamda2 = -(np'*(p2-p1))/(np'*n2); % 计算另一条支线和平面的交点
    pcross2 = p2+lamda2*n2; % 第二条直线交点位置
    dis = abs(nl'*(pcross2-p1)); % 构造三角形计算垂线长度
    lamda1 = (n1'*(pcross2-p1))/(n1'*n1);
    pcross1 = p1+lamda1*n1; % 第一条直线交点位置

    if (lamda1<=norm(B1-A1) && lamda1>=0) && (lamda2<=norm(B2-A2) && lamda2>=0) % 公垂线和线段2、线段2都相交
        varargout{1} = dis;
        varargout{2} = pcross1; % 第1条直线上的交点
        varargout{3} = pcross2; % 第2条直线上的交点
        varargout{4} = nl; % 公垂线方向向量
    elseif (lamda1<=norm(B1-A1) && lamda1>=0) && (lamda2>norm(B2-A2) || lamda2<0) % 公垂线和线段1相交
        lam1(1) = -(n1'*(p1-A2))/(n1'*n1); ddis(1) = norm(p1+lam1(1)*n1-A2);
        lam1(2) = -(n1'*(p1-B2))/(n1'*n1); ddis(2) = norm(p1+lam1(2)*n1-B2);
        if ddis(1)<=ddis(2)
            varargout{1} = ddis(1);
            varargout{2} = p1+lam1(1)*n1; % 第1条直线上的交点
            varargout{3} = A2; % 第2条直线上的交点
            varargout{4} = normS(p1+lam1(1)*n1-A2); % 最短线段方向向量
        else
            varargout{1} = ddis(2);
            varargout{2} = p1+lam1(2)*n1; % 第1条直线上的交点
            varargout{3} = B2; % 第2条直线上的交点
            varargout{4} = normS(p1+lam1(2)*n1-B2); % 最短线段方向向量
        end
    elseif (lamda1>norm(B1-A1) || lamda1<0) && (lamda2<=norm(B2-A2) && lamda2>=0) % 公垂线和线段2相交
        lam2(1) = -(n2'*(p2-A1))/(n2'*n2); ddis(1) = norm(p2+lam2(1)*n2-A1);
        lam2(2) = -(n2'*(p2-B1))/(n2'*n2); ddis(2) = norm(p2+lam2(2)*n2-B1);
        if ddis(1)<=ddis(2)
            varargout{1} = ddis(1);
            varargout{2} = A1; % 第1条直线上的交点
            varargout{3} = p2+lam2(1)*n2; % 第2条直线上的交点
            varargout{4} = normS(p2+lam2(1)*n2-A1); % 最短线段方向向量
        else
            varargout{1} = ddis(2);
            varargout{2} = B1; % 第1条直线上的交点
            varargout{3} = p2+lam2(2)*n2; % 第2条直线上的交点
            varargout{4} = normS(p2+lam2(2)*n2-B2); % 最短线段方向向量
        end
    else % 公垂线和线段1和2都不相交
        [varargout{1},varargout{2},varargout{3},varargout{4}] = distance(A1,B1,A2,B2);
    end
end

    function [dis,p1,p2,n] = distance(A1,B1,A2,B2)
        dddis(1) = norm(A1-A2);
        dddis(2) = norm(A1-B2);
        dddis(3) = norm(B1-A2);
        dddis(4) = norm(B1-B2);
        [M,I] = min(dddis);
        dis = M;
        switch I
            case 1
                p1 = A1; % 第1条直线上的交点
                p2 = A2; % 第2条直线上的交点
                n = normS(A1-A2); % 最短线段方向向量
            case 2
                p1 = A1; % 第1条直线上的交点
                p2 = B2; % 第2条直线上的交点
                n = normS(A1-B2); % 最短线段方向向量
            case 3
                p1 = B1; % 第1条直线上的交点
                p2 = A2; % 第2条直线上的交点
                n = normS(B1-A2); % 最短线段方向向量
            case 4
                p1 = B1; % 第1条直线上的交点
                p2 = B2; % 第2条直线上的交点
                n = normS(B1-B2); % 最短线段方向向量
        end
    end
end
