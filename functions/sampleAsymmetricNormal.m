% 在a和b中设置一个概率分布，其在c处取得最大概率，在a和b处的概率为零。
% Examples:
% samples = sampleAsymmetricNormal(a, b,c, 1000000);
% histogram(samples)
function sample = sampleAsymmetricNormal(a, b, c, N)
if c<=a || c>=b
    sample = NaN;
    disp('Error Input!');
    return;
end
% 定义概率密度函数
% pdf = @(x) exp(-1*(x - c).^2) .* (x>a) .* (x<b); % 高斯分布，仅在[a, b]区间内有效，系数越大，宽度越窄
pdf = @(x) (x >= a & x <= c).*(x-a)/(c-a) + (x > c & x <= b).*(b-x)/(b-c);


% 执行舍选法采样
sample = rejection_sampling(pdf, a, b, N);

% 定义拒绝采样的函数
    function sample = rejection_sampling(pdf, a, b, N)
        count = 0;
        while(1) % 接受采样，否则拒绝采样
            x = a + (b - a) * rand(1, 1); % 生成N个在[a, b]区间内的均匀随机数
            y = pdf(x); % 计算这些点的概率密度值
            u = rand(1, 1); % 生成N个在[0, 1]区间内的均匀随机数
            if u <= y
                count = count+1;
                sample(count) = x;
            end
            if count == N
                break;
            end
        end
    end
end