%%% ɢ��Բ׶��Ϻ���v
% version 1.0
% data 2021-6-14
% ����1 ����ÿһ�б�ʾһ�����xyz����
% ����2 ��ֵ��ǰ����Ԫ��Ϊ��������ϵ�±�����Բ׶���߽Ƕȣ�Ĭ�ϵ�λ������������Ԫ��ΪԲ׶׶���ǵ�һ��
% ���1 ���߷���
% ���2 ׶���ǵ�һ��
% ���3 Ŀ�꺯��ֵ���в�ͣ�
% note Ĭ��Բ׶����Ϊ[0;0;0]
function varargout = ConeFit(varargin)
A1 = [eye(3),zeros(3,1)];
A2 = [0,0,0,1];
p = varargin{1}; % ��������
M = max(max(p));
figure(1)
plot3S(p);
hold on
u = varargin{2}; % ������ֵ����Ҫ����׼һЩ
figure(2)
for i = 1:50
    x = [sin(u(1))*cos(u(2));sin(u(1))*sin(u(2));cos(u(1));u(3)];
    f = p'*A1*x-vecnorm(p)'*cos(A2*x);
    F = 1/2*f'*f;
    utmp = u;
    J = Jacobian(p,A1,A2,u(1),u(2),u(3));
    u = u-pinv(J)*f;
    err(i,1) = norm(u-utmp);
    err(i,2) = F;
    if err(i,2)<1e-10
        break
    end
    plot(err(:,1))
    pause(0.05)
end

varargout{1} = [sin(u(1))*cos(u(2));sin(u(1))*sin(u(2));cos(u(1))];
figure(1)
DrawLink(gcf,M*varargout{1},zeros(3,1),'color','r');
axis equal
varargout{2} = u(3);
varargout{3} = F;

    function J = Jacobian(p,A1,A2,fai,the,gamma)
        x = [sin(fai)*cos(the);sin(fai)*sin(the);cos(fai);gamma];
        par_f_x = p'*A1 + vecnorm(p)'*A2*sin(A2*x);
        par_x_fai = [cos(fai)*cos(the);cos(fai)*sin(the);-sin(fai);0];
        par_x_the = [-sin(fai)*sin(the);sin(fai)*cos(the);0;0];
        par_x_gamma = [0;0;0;1];
        J_fai = par_f_x*par_x_fai;
        J_the = par_f_x*par_x_the;
        J_gamma = par_f_x*par_x_gamma;
        J = [J_fai,J_the,J_gamma];
    end
end