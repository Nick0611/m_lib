%%% ɢ��Բ׶��Ϻ���v
% version 2.0
% data 2021-6-14
% ����1 ����ÿһ�б�ʾһ�����xyz����
% ����2 ��ֵ��ǰ����Ԫ��Ϊ��������ϵ�±�����Բ׶���߽Ƕȣ�Ĭ�ϵ�λ������������Ԫ��ΪԲ׶׶���ǵ�һ��;������Ԫ��ΪԲ׶��������
% ���1 ���߷���
% ���2 ׶���ǵ�һ��
% ���3 Բ׶��������
% ���4 Ŀ�꺯��ֵ���в�ͣ�
%%% Revise Data 2021-6-15
% ����cone3����Բ׶
%%% Revise Data 2021-6-19
% �����ж�����uΪ��������������
function varargout = ConeFitE(varargin)
A1 = [eye(3),zeros(3,4)];
A2 = [0,0,0,1,0,0,0];
A3 = [zeros(3,4),eye(3)];
p = varargin{1}; % ��������
M = max(max(p));
dim = max(size(p));
figure(1)
plot3S(p);
hold on
u = varargin{2}; % ������ֵ����Ҫ����׼һЩ
if size(u,1) == 1
    u=u';
end
figure(2)
for i = 1:50
    x = [sin(u(1))*cos(u(2));sin(u(1))*sin(u(2));cos(u(1));u(3);u(4);u(5);u(6)];
    for j = 1:dim
        f(j,1) = (p(:,j)-A3*x)'*A1*x-norm(p(:,j)-A3*x)*cos(A2*x);
        J(j,:) = Jacobian(p(:,j),A1,A2,A3,u(1),u(2),u(3),u(4),u(5),u(6));
    end
    F = 1/2*f'*f;
    utmp = u;
    u = u-pinv(J)*f;
    err(i,1) = norm(u-utmp);
    err(i,2) = F;
    if err(i,2)<1e-10
        break
    end
    plot(err(:,1))
    pause(0.05)
end
varargout{3} = u(4:6);
varargout{1} = [sin(u(1))*cos(u(2));sin(u(1))*sin(u(2));cos(u(1))];
figure(1)
DrawLink(gcf,M*varargout{1}+varargout{3},varargout{3},'color','r');
axis equal
cone3(M*varargout{1}+varargout{3},varargout{3},M*tan(u(3)))
varargout{2} = u(3);
varargout{4} = F;

    function J = Jacobian(p,A1,A2,A3,fai,the,gamma,px,py,pz)
        x = [sin(fai)*cos(the);sin(fai)*sin(the);cos(fai);gamma;px;py;pz];
        par_f_x = (p-A3*x)'*A1-x'*A1'*A3+norm(p-A3*x)*A2*sin(A2*x)+cos(A2*x)*(p-A3*x)'*A3/norm(p-A3*x);       
        par_x_fai = [cos(fai)*cos(the);cos(fai)*sin(the);-sin(fai);0;0;0;0];
        par_x_the = [-sin(fai)*sin(the);sin(fai)*cos(the);0;0;0;0;0];
        par_x_gamma = [0;0;0;1;0;0;0];
        par_x_px = [0;0;0;0;1;0;0];
        par_x_py = [0;0;0;0;0;1;0];
        par_x_pz = [0;0;0;0;0;0;1];
        J_fai = par_f_x*par_x_fai;
        J_the = par_f_x*par_x_the;
        J_gamma = par_f_x*par_x_gamma;
        J_px = par_f_x*par_x_px;
        J_py = par_f_x*par_x_py;
        J_pz = par_f_x*par_x_pz;
        J = [J_fai,J_the,J_gamma,J_px,J_py,J_pz];
    end
end