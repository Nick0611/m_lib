% function varargouot = InterferenceJudge(P_old,P_new)
% 功能：判断两根绳索在old和new位型过程中是否会发生碰撞
% 输入1：P_old =
% [A1_old,B1_old,A2_old,B2_old]，3 by 4，old位型下两根绳索线段两端的坐标。第一根绳索是A1B1，第二根绳索是A2B2
% 输入2 P_new = [A1_new,B1_new,A2_new,B2_new]，3 by 4
% 输出1：不会发生干涉输出1，会发生干涉输出-1
% 输出2：绳索A2B2在old位型下的方向向量向平面A1B1B2法向量方向的投影
% 输出3：绳索A2B2在new位型下的方向向量向平面A1B1B2法向量方向的投影
function varargout = InterferenceJudge(P_old,P_new)
A1_old = P_old(:,1);
B1_old = P_old(:,2);
A2_old = P_old(:,3);
B2_old = P_old(:,4);
A1_new = P_new(:,1);
B1_new = P_new(:,2);
A2_new = P_new(:,3);
B2_new = P_new(:,4);

n_old = normS(cross(A1_old-B1_old,B2_old-B1_old)); % B1_old、B2_old、A1_old构成的平面的法向量
con_old = dot(normS(A2_old-B2_old),n_old);

n_new = normS(cross(A1_new-B1_new,B2_new-B1_new)); % B1_new、B2_new、A1_new构成的平面的法向量
con_new = dot(normS(A2_new-B2_new),n_new);

varargout{1} = (con_new/con_old)/norm(con_new/con_old);
varargout{2} = con_old;
varargout{3} = con_new;