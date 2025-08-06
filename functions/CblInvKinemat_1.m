%%% function l = CblInvKinemat_1(A,b,g)
% author: Zachary Leung
% Date: 2023-3-23
% input1: 绳索出绳点全局坐标 3 by n
% input2: 绳索在动平台上的锚点的局部坐标 3 by n
% input3: 动平台坐标系相对于全局坐标系的位姿 4 by 4
% output1: 绳索长度 n by 1
function l = CblInvKinemat_1(A,b,g)
bh = b;
bh(4,:) = 1;
B = [eye(3),zeros(3,1)]*g*bh;
l = sqrt(diag((B-A)'*(B-A)));
