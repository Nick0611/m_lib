% function P = TrolleyForKine(m1,m2,m3,m4,m1_0,m2_0,m3_0,m4_0,params)
% 功能：平行四边形小车运动学正解，默认正中间为坐标系原点。
% 输入：m1，电机1的当前位置
% 输入：m2，电机2的当前位置
% 输入：m3，电机3的当前位置
% 输入：m4，电机4的当前位置
% 输入：m10，电机1的参考零点位置
% 输入：m20，电机2的参考零点位置
% 输入：m30，电机3的参考零点位置
% 输入：m40，电机4的参考零点位置
% 输入：params，几何参数，定义如下
% 作者：Zachary Liang
% 时间：2024-1-11
% params.ladder_top_length = 100; % 等效左右两个平行四边形上边中心点的间距
% params.link_length = 440; % 连杆长度
% params.ladder_down_homing_distance = 947; % 3#和4#电机零点位置的距离
function P = TrolleyForKine(m1,m2,m3,m4,m1_0,m2_0,m3_0,m4_0,params)

p1 = m1-m1_0;
p2 = -(m2-m2_0);
p3 = -(m3-m3_0);
p4 = -(m4-m4_0);
P(1,1) = 1/2*(p4-p3);
P(2,1) = p2;
P(3,1) = sqrt(params.link_length^2-(1/2*(params.ladder_down_homing_distance-params.ladder_top_length-p3-p4))^2);
