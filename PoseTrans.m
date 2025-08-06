function varargout=PoseTrans(x,pro)
%��ͬ��̬����֮���ת��
e1=[1;0;0]; E1=Wed(e1);
e2=[0;1;0]; E2=Wed(e2);
e3=[0;0;1]; E3=Wed(e3);
I3=eye(3);

switch pro
    case 'C2R' %�������ǵ���ת����
        varargout{1}=expm(E1*x(1))*expm(E2*x(2))*expm(E3*x(3));
    case 'R2C' %��ת���󵽿�������(ZYX) https://blog.csdn.net/c20081052/article/details/89479970
        r11=x(1,1); r12=x(1,2); r13=x(1,3);
        r23=x(2,3); r33=x(3,3);
        bet=asin(r13);
        alp=atan2(-r23,r33);
        gam=atan2(-r12,r11);
        varargout{1}=[alp;bet;gam];
    case 'F2R' %�̶�RPYת�ǵ���ת����
        varargout{1}=expm(E3*x(3)/180*pi)*expm(E2*x(2)/180*pi)*expm(E1*x(1)/180*pi);
    case 'R2F' %��ת���󵽹̶�RPYת��
        r21=x(2,1); r31=x(3,1);r32=x(3,2); 
        bet=-asin(r31);
        gam=asin(r21/cos(bet));
        alp=asin(r32/cos(bet));
        varargout{1}=[alp;bet;gam];
    case 'R2T' %��ת������������
        omeg=Vee(logm(x));
        varargout{1}=omeg;
    case 'R2Rodrigues' %��ת������������
        angle = acos((trace(x) - 1)/2); % ��ŷ���Ǳ���ת��Ϊ��Ƿ�����
        if abs(angle) < 1e-6
            Axis = [1 0 0];  % ������
        elseif abs(abs(angle)-pi)<1e-6
            angle = 0;
            if ~(abs(x(1,1)+1)<1e-6)
                Axis = [sqrt((x(1,1)+1)/2);x(1,2)/2/sqrt((x(1,1)+1)/2);x(1,3)/2/sqrt((x(1,1)+1)/2);];
            elseif ~(abs(x(2,2)+1)<1e-6)
                Axis = [0;sqrt((x(2,2)+1)/2);x(2,3)/2/sqrt((x(2,2)+1)/2)];
            else
                Axis = [0;0;1];
            end
        else
            % ������ת�ᣨ��λ������
            Axis = 1/(2*sin(angle)) * [
                x(3,2) - x(2,3);
                x(1,3) - x(3,1);
                x(2,1) - x(1,2)
                ]';
        end
        Axis = normS(Axis');
        varargout{1} = Axis;
        varargout{2} = angle;
    case 'T2R' %�������굽��ת����
        varargout{1}=expm(Wedge(x));
    case 'ZYX_Eular'
        the = -asin(x(3,1)); %y
        pu = atan2(x(3,2)/cos(the),x(3,3)/cos(the)); %x
        fai = atan2(x(2,1)/cos(the),x(1,1)/cos(the)); %z
        %         y = [fai;the;pu];
        varargout{1} = [pu;the;fai];
    case 'R2XYZFixed'
        % ��ȡ����Ԫ��
        r11 = x(1,1); r12 = x(1,2); r13 = x(1,3);
        r21 = x(2,1); r22 = x(2,2); r23 = x(2,3);
        r31 = x(3,1); r32 = x(3,2); r33 = x(3,3);

        % ���㸩���Ǧ� (Y��)
        theta = atan2(-r31, sqrt(r11^2 + r21^2));

        % �������Ǧ� (X��)��ƫ���Ǧ� (Z��)
        if abs(theta - pi/2) < 1e-6
            phi = 0;
            psi = atan2(r12, r22);
        elseif abs(theta + pi/2) < 1e-6
            phi = 0;
            psi = -atan2(r12, r22);
        else
            phi = atan2(r32, r33);
            psi = atan2(r21, r11);
        end
        varargout{1} = [phi;theta;psi]; % [x,y,z]˳��
end