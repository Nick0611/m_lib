%%% TwoLineDist
% ���� �����d
% Date 2021-06-25
% ������ֱ�߾���
% ����1 ��һ��ֱ��6by1��ǰ����Ԫ���Ƿ��򣬺�����Ԫ����λ��
% ����2 �ڶ���ֱ��6by1��ǰ����Ԫ���Ƿ��򣬺�����Ԫ����λ��
% ���1 ����
% ���2 ��1��ֱ���ϵĽ���
% ���3 ��2��ֱ���ϵĽ���
% ���4 �����߷�������

% Revision
% 2022-7-21
% �޸���ֱ��ƽ��ʱ�ĺ��������ʾ
function varargout = TwoLineDist(ksi1,ksi2)
n1 = reshape(ksi1(1:3),3,1); p1 = reshape(ksi1(4:6),3,1);
n2 = reshape(ksi2(1:3),3,1); p2 = reshape(ksi2(4:6),3,1);
if norm(cross(n1,n2)) == 0 % �ж��Ƿ�ƽ��
    dis = sqrt(norm(p2-p1)^2-(n1'*(p2-p1))^2);
    disp('����ֱ��ƽ��')  
    varargout{1} = dis;
    for i = 2:nargout
        varargout{i} = [];
    end
else
    nl = cross(n1,n2); nl =  nl/norm(nl); % ���칫����
    np = cross(nl,n1); np =  np/norm(np); % ���칫���ߺ�һ��ֱ�ߵ�ƽ��
    lamda2 = -(np'*(p2-p1))/(np'*n2); % ������һ��֧�ߺ�ƽ��Ľ���
    pcross2 = p2+lamda2*n2; % �ڶ���ֱ�߽���λ��
    dis = abs(nl'*(pcross2-p1)); % ���������μ��㴹�߳���
    lamda1 = (n1'*(pcross2-p1))/(n1'*n1);
    pcross1 = p1+lamda1*n1; % ��һ��ֱ�߽���λ��
    varargout{1} = dis;
    varargout{2} = pcross1; % ��1��ֱ���ϵĽ���
    varargout{3} = pcross2; % ��2��ֱ���ϵĽ���
    varargout{4} = nl; % �����߷�������
end
