%% T_Matrix
% �ƹ̶�����ϵ����ת������Xתalpha������Yתbeta������Zתgamma����T=Rz(gamma)Ry(beta)Rx(alpha)��
%       ��������� �̶�����ϵ �µ�����任����������ת����ԵĶ��� �� ����ϵ�е������ᣬ
%       �� u_������ϵ�е����� = T*u_������ϵ�е����ꣻ
%       ��������Ǹ���任������һ���̶�����ϵ�У�һ���������Ź̶����������������ת����
%       u_new_��ͬһ������ϵ�µ����� = T*u_old��
% Eular�ǣ�������ϵ����Zתgamma��������Yתbeta����������Xתalpha�õ�������ϵ��
%       ��T=Rz(gamma)Ry(beta)Rx(alpha)��
%       ��������� �涯����ϵ �µ�����任����������ת����ԵĶ��� �� ����ϵ�е������ᣬ
%       �� u_������ϵ�е����� = T*u_������ϵ�е����ꣻ
%       ��������Ǹ���任�����ڸ����涯����ϵ�У�һ�����������涯����ϵ���������������ת����
%       u_new_��ͬһ������ϵ�µ����� = T*u_old��
% ��������RPY���ǣ���Eular����ʽ��ͬ�������Ƶ��᲻ͬ��
%       ����Xתalpha��������Yתbeta����������Zתgamma����T=Rx(alpha)Ry(beta)Rz(gamma)��
%   ��ΪR�����о��Ǳ任�������ϵ��������������ϵ�µ�ͶӰ���ꡣ
% RPY�ǰ���ת�Ⱥ��������ˣ�Eular�ǰ���ת�Ⱥ�������ҳ�
% ����1~����6��ǰ���������ֱ���x��y��z����ת ���ȣ�Ҫע������  ������������xyz���������ƽ��
% ����7��˳��
% ����8��Eular | rpy
% ���1��R
% ���2��T
% Ĭ��Eular��Z-Y-X˳�棻Ĭ�������ת����R
% note���������������xyz��rpy������zyx��eular������˷����ɽ�����
% note��zyx��eular���ı���z����תҲ���ǵ�һ����ת��ĩ������ϵ�Ż���ֳ���z����ת���������ҵġ�
% note������rpy�������涯�Ͳ������������⣡
% Revision
% Date 2021-6-20
% ����help����
% Revision2024-6-19��Դ�����и�bug��ֻ�ܴ���zyx����xyz����x/y/z�����ᶼ���ڵ����������xzx���־Ͳ��ܴ����ˣ�
% ��ΪĬ��ǰ������������x��y��z���ת�ǣ����Ը�����T_Matrix_2����
%%
function [varargout]=T_Matrix(varargin)
R = eye(3);
if isempty(varargin)
    fprintf("       T_Matrix: Please give correct input!");
    return;
end
if length(varargin) >= 3       % if nargin >= 3
    alpha = varargin{1};       % about x
    beta = varargin{2};        % about y
    gamma = varargin{3};       % about z
end
if length(varargin) == 3 || length(varargin) == 6
    str1 = 'Z-Y-X';        % rotation ordor
    str1 = deblank(str1);
end

if length(varargin) <6
    str1 = lower(varargin{4});
    str1 = deblank(str1);
end
if length(varargin) >= 6       % if nargin == 7
    a = varargin{4};       % along x
    b = varargin{5};       % along y
    c = varargin{6};       % along z
end
if length(varargin) >= 7
    str1 = lower(varargin{7});
    str1 = deblank(str1);
end
str1 = lower(str1);
S = strsplit(str1,{'-'});
str2 = "Eular";
if length(varargin) == 8
    str2 = lower(varargin{8});
    if(~strcmp(str2,"eular") && ~strcmp(str2,"rpy"))
        fprintf("     Please give correct input!\n");
        return
    end
end

Rx = [1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];
Rz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
if(lower(str2) == "eular")
    for i = 1:length(S)
        s(i) = char(S(i));
        switch s(i)
            case 'x'
                R = R*Rx;
            case 'y'
                R = R*Ry;
            case 'z'
                R = R*Rz;
        end
    end
end
if(lower(str2) == "rpy")
    for i = 1:length(S)
        s(i) = char(S(i));
        switch s(i)
            case 'x'
                R = Rx*R;
            case 'y'
                R = Ry*R;
            case 'z'
                R = Rz*R;
        end
    end
end
if nargout >=0
    varargout{1} = R;
end
if nargout == 2
    varargout{2} = [R,[a;b;c];zeros(1,3),1];
end
