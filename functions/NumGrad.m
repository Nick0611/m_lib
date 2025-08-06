%%% x = NumGrad(f,x0,data,prc)
% 计算数值梯度，并且采用梯度优化算法获得最优解
% 时间：2022-7-22
% 输入1：函数值计算函数的句柄 用 @+函数名输入 m by 1
% 输入2：自变量初值 n by 1
% 输入3：计算函数值所需要的数据
% 输入4：精度，0.00001
% 输出1：迭代之后的自变量结果 n by 1

% revision 2022-8-12
% 根据notion记录的LM算法，修改
function varargout = NumGrad(f,x0,data,prc)
x = x0;
dimx = size(x,1);

for iter = 1:80
    tic;
    iter
    d1 = f(x,data);
    for i = 1:dimx
        N = zeros(dimx,1);
        N(i) = prc;
        tmp =  f(x+N,data);
        d2(:,i) = tmp;
    end
    J = [d2-d1]/prc; %输出行元素对自变量元素的偏导
    
    % 高斯牛顿法
    Delta = -pinv(J)*d1;
    x = x + 0.1*Delta   
    
%     % 列文伯格方法
%     F1 = 1/2*(d1'*d1);
%     H = J'*J;
%     if iter==1
%         % 初始化值λ
%         lambda = prc*max(diag(H));
%         v=2;
%     else
%         % 更新值λ
%         d2tmp = f(x-Delta,data);
%         F2 = 1/2*(d2tmp'*d2tmp); % old
%         L2 = 1/2*((J*(x-Delta)-d1))'*((J*(x-Delta)-d1)); % old
%         L1 = 1/2*(J*Delta-(J*(x-Delta)-d1))'*(J*Delta-(J*(x-Delta)-d1));
%         beta = (F1-F2)/(L1-L2);
%         if beta>0
%             lambda = lambda * max([1/3;1-power(2*beta-1,3)]);
%             v = 2;
%         else
%             lambda = lambda*v;
%             v = 2*v;
%         end
%     end
%     
%     Delta = -(lambda*eye(dimx)+J'*J)\J'*d1;
%     x = x + 0.1*Delta;

    %
    yr(iter) = norm(d1);
    yr(iter)
    toc;
    if norm(Delta,'Inf')<1e-6
        break;
    end
end
%     plot(yr)
    varargout{1} = x;
    varargout{2} = yr;
end
