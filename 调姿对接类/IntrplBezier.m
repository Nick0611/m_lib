%%% function g = IntrplBezier(a,num,varargin)
% 功能： 两个SE(3)关键点之间在t位置的插值点
% 注意： 最开始和最结束的两个关键点之间进行二次插值，中间的两个点之间进行三次插值
% 方案一：这里控制点的选取是等比例的左右两边，只保证关键点处的切线方向相同
% 方案二：这里控制点的选取是等距离的左右两边，保证关键点处的切线斜率相同
% 输入1： a 平滑程度，每个关键点两侧的控制点向外延伸的长度
% 输入2： num 相邻两个控制点之间的插值数量
% 输入3~n： SE(3)形式的关键点，g1，g2，...，gn，依次写出即可
% 输出1： 插值后的结果，嵌套的元胞形式{1,n-1}{1,num}，相邻关键点之间插入num个SE(3)
% 作者： Zachary Liang
% 时间： 2023-5-23
% Revision 20230528
% 如果输入为2个，则直接进行一次插值，调用IntrplLee 
% Revision 20230712
% 原来的插值结果前一段的最后点和后一段的最前点值是一样的，会导致不连续，现在删掉其中一个点
% 中间关键点之间的插值逻辑修改，取消掉while循环
% 问题：首尾三阶插值和中间的四阶插值不连续过渡，对应的修改：
% 首段和尾段也四阶插值，控制点z0和zend由当前关键点和零插值。
% Revision 20230727
% 修改n=2,n=3也为三阶插值
% Revision 20240624
% n=2时，修改z0和zend的取值，不是跟单位矩阵求插值，就是跟输入的两个g之间先取a做两个关键点，然后再Bezier插值。
% Revision 20240827
% n=3及以上时，修改z0和zend的取值，不是跟单位矩阵求插值，就是相邻两个g之间先取a做两个关键点，然后再Bezier插值。
% 改完了
% Revision 20250705
% 不直接给插值数量，而是给插值间隔，自适应计算插值数量。因为有可能离得很远或者离的很近。
function g = IntrplBezier(a,Interval,varargin)
n = nargin-2;
% 方案一
% if n == 2
%     g{1} = IntrplLee(num,varargin{1},varargin{2}); % 李群轨迹插值函数
% end
% if n == 3
%     z{1} = varargin{2}*expm(-a*norm(Vee(logm(pinv(varargin{1})*varargin{2})))*logm(pinv(varargin{1})*varargin{3})/norm(Vee(logm(pinv(varargin{1})*varargin{3}))));
%     z{2} = varargin{2}*expm(a*norm(Vee(logm(pinv(varargin{2})*varargin{3})))*logm(pinv(varargin{1})*varargin{3})/norm(Vee(logm(pinv(varargin{1})*varargin{3}))));
%     g{1} = IntrplLee(num,varargin{1},z{1},varargin{2}); % 李群轨迹插值函数
%     g{2} = IntrplLee(num,varargin{2},z{2},varargin{3}); % 李群轨迹插值函数
% end
% if n > 3
%     while(n-3)
%         for i = 1:n-3
%             z{i} = varargin{i+1}*expm(-a*norm(Vee(logm(pinv(varargin{i})*varargin{i+1})))*logm(pinv(varargin{i})*varargin{i+2})/norm(Vee(logm(pinv(varargin{i})*varargin{i+2}))));
%             z{i+1} = varargin{i+1}*expm(a*norm(Vee(logm(pinv(varargin{i+1})*varargin{i+2})))*logm(pinv(varargin{i})*varargin{i+2})/norm(Vee(logm(pinv(varargin{i})*varargin{i+2}))));
%             z{i+2} = varargin{i+2}*expm(-a*norm(Vee(logm(pinv(varargin{i+1})*varargin{i+2})))*logm(pinv(varargin{i+1})*varargin{i+3})/norm(Vee(logm(pinv(varargin{i+1})*varargin{i+3}))));
%             z{i+3} = varargin{i+2}*expm(a*norm(Vee(logm(pinv(varargin{i+2})*varargin{i+3})))*logm(pinv(varargin{i+1})*varargin{i+3})/norm(Vee(logm(pinv(varargin{i+1})*varargin{i+3}))));
%             g{i+1} = IntrplLee(num,varargin{i+1},z{i+1},z{i+2},varargin{i+2}); % 李群轨迹插值函数
%         end
%         n = n-1;
%     end
%     g{1} = IntrplLee(num,varargin{1},z{1},varargin{2}); % 李群轨迹插值函数
%     g{i+2} = IntrplLee(num,varargin{i+2},z{i+3},varargin{i+3}); % 李群轨迹插值函数
% end
% 方案二
if n == 2
    %     z0 = varargin{1}*expm(a*logm(pinv(eye(4))*varargin{2}));
    %     zend = varargin{2}*expm(-a*logm(pinv(varargin{1})*eye(4)));
    z0 = varargin{1}*expm(a*logm(pinv(varargin{1})*varargin{2}));
    zend = varargin{2}*expm(-a*logm(pinv(varargin{1})*varargin{2}));
%     z0 = varargin{1};
%     zend = varargin{2};
    num = max(4,round(norm(Vee(logm(varargin{1}\varargin{2}))) / Interval));
    g{1} = IntrplLee(num,varargin{1},z0,zend,varargin{2}); % 李群轨迹插值函数
end
if n == 3
%     z0 = varargin{1}*expm(a*logm(pinv(eye(4))*varargin{2}));
    z0 = varargin{1}*expm(a*logm(pinv(varargin{1})*varargin{2}));
    z{1} = varargin{2}*expm(-a*logm(pinv(varargin{1})*varargin{3}));
    z{2} = varargin{2}*expm(a*logm(pinv(varargin{1})*varargin{3}));
%     zend = varargin{3}*expm(-a*logm(pinv(varargin{2})*eye(4)));
    zend = varargin{3}*expm(-a*logm(pinv(varargin{2})*varargin{3}));
    num = max(4,round(norm(Vee(logm(varargin{1}\varargin{2}))) / Interval));
    g{1} = IntrplLee(num,varargin{1},z0,z{1},varargin{2}); % 李群轨迹插值函数
    num = max(4,round(norm(Vee(logm(varargin{2}\varargin{3}))) / Interval));
    g{2} = IntrplLee(num,varargin{2},z{2},zend,varargin{3}); % 李群轨迹插值函数
end
if n > 3
    z = coder.nullcopy(cell(1,n));
%     while(n-3)
        for i = 1:n-3
            z{i} = varargin{i+1}*expm(-a*logm(pinv(varargin{i})*varargin{i+2}));
            z{i+1} = varargin{i+1}*expm(a*logm(pinv(varargin{i})*varargin{i+2}));
            z{i+2} = varargin{i+2}*expm(-a*logm(pinv(varargin{i+1})*varargin{i+3}));
            z{i+3} = varargin{i+2}*expm(a*logm(pinv(varargin{i+1})*varargin{i+3}));
            num = max(4,round(norm(Vee(logm(varargin{i+1}\varargin{i+2}))) / Interval));
            g{i+1} = IntrplLee(num,varargin{i+1},z{i+1},z{i+2},varargin{i+2}); % 李群轨迹插值函数
        end
%         n = n-1;
%     end
%     z0 = varargin{1}*expm(a*logm(pinv(eye(4))*varargin{2}));
    z0 = varargin{1}*expm(a*logm(pinv(varargin{1})*varargin{2}));
%     zend = varargin{i+3}*expm(-a*logm(pinv(varargin{i+2})*eye(4)));
    zend = varargin{i+3}*expm(-a*logm(pinv(varargin{i+2})*varargin{i+3}));
    num = max(4,round(norm(Vee(logm(varargin{1}\varargin{2}))) / Interval));
    g{1} = IntrplLee(num,varargin{1},z0,z{1},varargin{2}); % 李群轨迹插值函数
    num = max(4,round(norm(Vee(logm(varargin{i+2}\varargin{i+3}))) / Interval));
    g{i+2} = IntrplLee(num,varargin{i+2},z{i+3},zend,varargin{i+3}); % 李群轨迹插值函数
end
% Revision 20230712
for i = 1:size(g,2)-1
    g{i}(end)=[];
end