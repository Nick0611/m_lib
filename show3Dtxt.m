%%% 读取txt文件中物体的三维坐标，显示三维模型
% 输入：点云txt数据路径

function show3Dtxt(varargin)
%%read 3D data
str = varargin{1};
fileID= fopen(str,'r');  
%txt文件读成三维元胞数组cell形式
A = textscan(fileID,'%d %d %d'); 
fclose(fileID);
%X,Y,Z数据类型均为 1*1 cell
X=A(:,1);  
Y=A(:,2);  
Z=A(:,3); 
%将元胞数组转化为矩阵形式
x=cell2mat(X);  
y=cell2mat(Y);  
z=cell2mat(Z);  
%%show 3D data 
plot3(x,y,z,'ro'); %红色圆点 
xlabel('x轴'),ylabel('y轴'),zlabel('z轴')  
grid on