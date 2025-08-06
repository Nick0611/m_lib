%%% function g = IntrplBezier(a,num,varargin)
% ���ܣ� ����SE(3)�ؼ���֮����tλ�õĲ�ֵ��
% ע�⣺ �ʼ��������������ؼ���֮����ж��β�ֵ���м��������֮��������β�ֵ
% ����һ��������Ƶ��ѡȡ�ǵȱ������������ߣ�ֻ��֤�ؼ��㴦�����߷�����ͬ
% ��������������Ƶ��ѡȡ�ǵȾ�����������ߣ���֤�ؼ��㴦������б����ͬ
% ����1�� a ƽ���̶ȣ�ÿ���ؼ�������Ŀ��Ƶ���������ĳ���
% ����2�� num �����������Ƶ�֮��Ĳ�ֵ����
% ����3~n�� SE(3)��ʽ�Ĺؼ��㣬g1��g2��...��gn������д������
% ���1�� ��ֵ��Ľ����Ƕ�׵�Ԫ����ʽ{1,n-1}{1,num}�����ڹؼ���֮�����num��SE(3)
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-5-23
% Revision 20230528
% �������Ϊ2������ֱ�ӽ���һ�β�ֵ������IntrplLee 
% Revision 20230712
% ԭ���Ĳ�ֵ���ǰһ�ε�����ͺ�һ�ε���ǰ��ֵ��һ���ģ��ᵼ�²�����������ɾ������һ����
% �м�ؼ���֮��Ĳ�ֵ�߼��޸ģ�ȡ����whileѭ��
% ���⣺��β���ײ�ֵ���м���Ľײ�ֵ���������ɣ���Ӧ���޸ģ�
% �׶κ�β��Ҳ�Ľײ�ֵ�����Ƶ�z0��zend�ɵ�ǰ�ؼ�������ֵ��
% Revision 20230727
% �޸�n=2,n=3ҲΪ���ײ�ֵ
% Revision 20240624
% n=2ʱ���޸�z0��zend��ȡֵ�����Ǹ���λ�������ֵ�����Ǹ����������g֮����ȡa�������ؼ��㣬Ȼ����Bezier��ֵ��
% Revision 20240827
% n=3������ʱ���޸�z0��zend��ȡֵ�����Ǹ���λ�������ֵ��������������g֮����ȡa�������ؼ��㣬Ȼ����Bezier��ֵ��
% ������
% Revision 20250705
% ��ֱ�Ӹ���ֵ���������Ǹ���ֵ���������Ӧ�����ֵ��������Ϊ�п�����ú�Զ������ĺܽ���
function g = IntrplBezier(a,Interval,varargin)
n = nargin-2;
% ����һ
% if n == 2
%     g{1} = IntrplLee(num,varargin{1},varargin{2}); % ��Ⱥ�켣��ֵ����
% end
% if n == 3
%     z{1} = varargin{2}*expm(-a*norm(Vee(logm(pinv(varargin{1})*varargin{2})))*logm(pinv(varargin{1})*varargin{3})/norm(Vee(logm(pinv(varargin{1})*varargin{3}))));
%     z{2} = varargin{2}*expm(a*norm(Vee(logm(pinv(varargin{2})*varargin{3})))*logm(pinv(varargin{1})*varargin{3})/norm(Vee(logm(pinv(varargin{1})*varargin{3}))));
%     g{1} = IntrplLee(num,varargin{1},z{1},varargin{2}); % ��Ⱥ�켣��ֵ����
%     g{2} = IntrplLee(num,varargin{2},z{2},varargin{3}); % ��Ⱥ�켣��ֵ����
% end
% if n > 3
%     while(n-3)
%         for i = 1:n-3
%             z{i} = varargin{i+1}*expm(-a*norm(Vee(logm(pinv(varargin{i})*varargin{i+1})))*logm(pinv(varargin{i})*varargin{i+2})/norm(Vee(logm(pinv(varargin{i})*varargin{i+2}))));
%             z{i+1} = varargin{i+1}*expm(a*norm(Vee(logm(pinv(varargin{i+1})*varargin{i+2})))*logm(pinv(varargin{i})*varargin{i+2})/norm(Vee(logm(pinv(varargin{i})*varargin{i+2}))));
%             z{i+2} = varargin{i+2}*expm(-a*norm(Vee(logm(pinv(varargin{i+1})*varargin{i+2})))*logm(pinv(varargin{i+1})*varargin{i+3})/norm(Vee(logm(pinv(varargin{i+1})*varargin{i+3}))));
%             z{i+3} = varargin{i+2}*expm(a*norm(Vee(logm(pinv(varargin{i+2})*varargin{i+3})))*logm(pinv(varargin{i+1})*varargin{i+3})/norm(Vee(logm(pinv(varargin{i+1})*varargin{i+3}))));
%             g{i+1} = IntrplLee(num,varargin{i+1},z{i+1},z{i+2},varargin{i+2}); % ��Ⱥ�켣��ֵ����
%         end
%         n = n-1;
%     end
%     g{1} = IntrplLee(num,varargin{1},z{1},varargin{2}); % ��Ⱥ�켣��ֵ����
%     g{i+2} = IntrplLee(num,varargin{i+2},z{i+3},varargin{i+3}); % ��Ⱥ�켣��ֵ����
% end
% ������
if n == 2
    %     z0 = varargin{1}*expm(a*logm(pinv(eye(4))*varargin{2}));
    %     zend = varargin{2}*expm(-a*logm(pinv(varargin{1})*eye(4)));
    z0 = varargin{1}*expm(a*logm(pinv(varargin{1})*varargin{2}));
    zend = varargin{2}*expm(-a*logm(pinv(varargin{1})*varargin{2}));
%     z0 = varargin{1};
%     zend = varargin{2};
    num = max(4,round(norm(Vee(logm(varargin{1}\varargin{2}))) / Interval));
    g{1} = IntrplLee(num,varargin{1},z0,zend,varargin{2}); % ��Ⱥ�켣��ֵ����
end
if n == 3
%     z0 = varargin{1}*expm(a*logm(pinv(eye(4))*varargin{2}));
    z0 = varargin{1}*expm(a*logm(pinv(varargin{1})*varargin{2}));
    z{1} = varargin{2}*expm(-a*logm(pinv(varargin{1})*varargin{3}));
    z{2} = varargin{2}*expm(a*logm(pinv(varargin{1})*varargin{3}));
%     zend = varargin{3}*expm(-a*logm(pinv(varargin{2})*eye(4)));
    zend = varargin{3}*expm(-a*logm(pinv(varargin{2})*varargin{3}));
    num = max(4,round(norm(Vee(logm(varargin{1}\varargin{2}))) / Interval));
    g{1} = IntrplLee(num,varargin{1},z0,z{1},varargin{2}); % ��Ⱥ�켣��ֵ����
    num = max(4,round(norm(Vee(logm(varargin{2}\varargin{3}))) / Interval));
    g{2} = IntrplLee(num,varargin{2},z{2},zend,varargin{3}); % ��Ⱥ�켣��ֵ����
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
            g{i+1} = IntrplLee(num,varargin{i+1},z{i+1},z{i+2},varargin{i+2}); % ��Ⱥ�켣��ֵ����
        end
%         n = n-1;
%     end
%     z0 = varargin{1}*expm(a*logm(pinv(eye(4))*varargin{2}));
    z0 = varargin{1}*expm(a*logm(pinv(varargin{1})*varargin{2}));
%     zend = varargin{i+3}*expm(-a*logm(pinv(varargin{i+2})*eye(4)));
    zend = varargin{i+3}*expm(-a*logm(pinv(varargin{i+2})*varargin{i+3}));
    num = max(4,round(norm(Vee(logm(varargin{1}\varargin{2}))) / Interval));
    g{1} = IntrplLee(num,varargin{1},z0,z{1},varargin{2}); % ��Ⱥ�켣��ֵ����
    num = max(4,round(norm(Vee(logm(varargin{i+2}\varargin{i+3}))) / Interval));
    g{i+2} = IntrplLee(num,varargin{i+2},z{i+3},zend,varargin{i+3}); % ��Ⱥ�켣��ֵ����
end
% Revision 20230712
for i = 1:size(g,2)-1
    g{i}(end)=[];
end