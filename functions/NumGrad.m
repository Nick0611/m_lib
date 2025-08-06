%%% x = NumGrad(f,x0,data,prc)
% ������ֵ�ݶȣ����Ҳ����ݶ��Ż��㷨������Ž�
% ʱ�䣺2022-7-22
% ����1������ֵ���㺯���ľ�� �� @+���������� m by 1
% ����2���Ա�����ֵ n by 1
% ����3�����㺯��ֵ����Ҫ������
% ����4�����ȣ�0.00001
% ���1������֮����Ա������ n by 1

% revision 2022-8-12
% ����notion��¼��LM�㷨���޸�
function varargout = NumGrad(f,x0,data,prc)
x = x0;
dimx = size(x,1);

for iter = 1:80
    tic;
    iter
    d1 = f(x,data);
    for i = 1:dimx
        N = zeros(dimx,1);
        N(i) = prc;
        tmp =  f(x+N,data);
        d2(:,i) = tmp;
    end
    J = [d2-d1]/prc; %�����Ԫ�ض��Ա���Ԫ�ص�ƫ��
    
    % ��˹ţ�ٷ�
    Delta = -pinv(J)*d1;
    x = x + 0.1*Delta   
    
%     % ���Ĳ��񷽷�
%     F1 = 1/2*(d1'*d1);
%     H = J'*J;
%     if iter==1
%         % ��ʼ��ֵ��
%         lambda = prc*max(diag(H));
%         v=2;
%     else
%         % ����ֵ��
%         d2tmp = f(x-Delta,data);
%         F2 = 1/2*(d2tmp'*d2tmp); % old
%         L2 = 1/2*((J*(x-Delta)-d1))'*((J*(x-Delta)-d1)); % old
%         L1 = 1/2*(J*Delta-(J*(x-Delta)-d1))'*(J*Delta-(J*(x-Delta)-d1));
%         beta = (F1-F2)/(L1-L2);
%         if beta>0
%             lambda = lambda * max([1/3;1-power(2*beta-1,3)]);
%             v = 2;
%         else
%             lambda = lambda*v;
%             v = 2*v;
%         end
%     end
%     
%     Delta = -(lambda*eye(dimx)+J'*J)\J'*d1;
%     x = x + 0.1*Delta;

    %
    yr(iter) = norm(d1);
    yr(iter)
    toc;
    if norm(Delta,'Inf')<1e-6
        break;
    end
end
%     plot(yr)
    varargout{1} = x;
    varargout{2} = yr;
end
