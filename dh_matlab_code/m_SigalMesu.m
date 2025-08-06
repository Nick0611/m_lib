%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     ���ž������DHת������ʽ
% 1���������ܣ�[Dof,A] = m_SigalMesu(DH_table_or_excelname,sheetname,range)
%    ���÷��ž��� or excel�ļ����� D-H�������Զ����ת������
%    DH_table_or_excelname ���� DH�������ž��� or ����DH��������excel�ļ���
%    sheetname ���� ֻ����excel����ʱ��������ã�����ʾ����������excel�ļ���sheetname sheet��
%    range ���� ֻ����excel����ʱ��������ã�����ʾDH������Χ
%    Dof ���� ת���������
%    A   ���� ת��������ά���ݡ�A(:,:,i)Ϊ��õĵ�i��DH�ַ�����
%
% 2��D-H���������ʽ��
%    [����1����a1 ����1Ť��aerf1 �ؽ�1ƫ����d1 �ؽ�1�Ƕ�theta1;
%     ����2����a2 ����2Ť��aerf2 �ؽ�2ƫ����d2 �ؽ�2�Ƕ�theta2;
%                            ....                            ]   
%    ���ž���ֱ�Ӵ���������
%    1��M = sym('[a,2*b;3*a,0]');
%    2) M = str2sym('[a,2*b;3*a,0]');
%  ע��sym�������ܲ�������
%
% 3����excel���������ʽ��
%    [Dof,A] = m_SigalMesu('excelname','sheetname','range')
%  �磺[Dof,A] = m_SigalMesu('dh_test.xlsx','sheet1','B2:E8')
%
%
%
%  ע���ú����������һ�����������ʾ����ΪDH�������ž���
%      �����Ҫ��excel���룬����Ҫ�����Լ������Ĳ��������룺
%      excel�ļ�����sheet����������ӦDH������Χ
%      Ϊstandard-DH���󣬼�����
%
% 2019��5��15��
% csdn��������BinHeon
%           https://blog.csdn.net/BinHeon/article/details/90245890
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Dof,A] = m_SigalMesu(DH_table_or_excelname,sheetname,range)

%%%% %%%% %%%% �����������
if nargin == 1       %%%% ����һ��������Ĭ�ϸò���ΪDH�����ַ�����
    DH_table = DH_table_or_excelname;
end
if nargin == 3       %%%% ��������������Ĭ�ϵ�һ����Ϊexcel�����ڶ�Ϊsheet��������Ϊ��Χ
% ��ȡexcel�ļ��е����ݷ�����
% ����1��[data,text] = xlsread(FileName, SheetName, Range);
% data����������ݵ�Ԫ���ֵ�� text��������ַ�����Ԫ�������
% ����2��[~,~,dh_table] = xlsread(FileName, SheetName, Range);
    [~,~,dh_table] = xlsread(DH_table_or_excelname,sheetname,range); % ����excel�в�����
    DH_table = sym(dh_table); % ������������ַ���
end

%%%% %%%% %%%% ���D-H�������� ת��������Ŀ
[m,n] = size(DH_table); % mΪ��Ŀ
Dof = m;
%%%% %%%% %%%% ����ÿ��ת������
%%%% ������ű���
% syms c_theta s_theta c_aerf s_aerf a d; % ������ű���
% %%%% ����d-hת������ʽ 
% dh_A = [c_theta , -s_theta*c_aerf , s_theta*s_aerf , a*c_theta ;
%         s_theta ,  c_theta*c_aerf , -c_theta*s_aerf, a*s_theta ;
%         0       ,     s_aerf      ,     c_aerf     ,     d     ;
%         0       ,       0         ,        0       ,     1      ];% D-H���㹫ʽ

syms a aerf d theta; % ������ű�����a���˳��� aerf����Ť�� d�ؽ�ƫ�� theta�ؽ�ת��
%%%% ����d-hת������ʽ 
dh_A = [cos(theta) , -sin(theta)*cos(aerf) , sin(theta)*sin(aerf) , a*cos(theta) ;
        sin(theta) ,  cos(theta)*cos(aerf) , -cos(theta)*sin(aerf), a*sin(theta) ;
           0       ,       sin(aerf)       ,       cos(aerf)      ,       d      ;
           0       ,            0          ,            0         ,       1      ];% D-H���㹫ʽ

%%%% ����ÿ��ת������ Ai ,���� Ai �����ά���� A ���棻�Ӷ����㺯������
for i=1:m % �ܹ��� m �� ת������

    % ����D-H�������ʼ����ӦD-H����
    t_a = DH_table(i,1);    % ���D-H�������е�i��d-h������ ���˳���
    t_aerf = DH_table(i,2); % ���D-H�������е�i��d-h������ ����Ť��
    t_d = DH_table(i,3);    % ���D-H�������е�i��d-h������ �ؽ�ƫ��
    t_theta = DH_table(i,4);% ���D-H�������е�i��d-h������ �ؽ�ƫ��
    % ��ô��������ķ��ž��󣬼�ת������A(i)
    A(:,:,i) = subs(dh_A,[a aerf d theta],[t_a t_aerf t_d t_theta]);
       % ��ʼ����ά����A�е�i����ά����ΪD-H����
           % ע�⣬subs�����������ı�ԭ����dh_A�ķ��ž���
               % ��ֻ�Ƿ��ش���dh_A���ž������õ����·��ž���
    
end


