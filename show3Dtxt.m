%%% ��ȡtxt�ļ����������ά���꣬��ʾ��άģ��
% ���룺����txt����·��

function show3Dtxt(varargin)
%%read 3D data
str = varargin{1};
fileID= fopen(str,'r');  
%txt�ļ�������άԪ������cell��ʽ
A = textscan(fileID,'%d %d %d'); 
fclose(fileID);
%X,Y,Z�������;�Ϊ 1*1 cell
X=A(:,1);  
Y=A(:,2);  
Z=A(:,3); 
%��Ԫ������ת��Ϊ������ʽ
x=cell2mat(X);  
y=cell2mat(Y);  
z=cell2mat(Z);  
%%show 3D data 
plot3(x,y,z,'ro'); %��ɫԲ�� 
xlabel('x��'),ylabel('y��'),zlabel('z��')  
grid on