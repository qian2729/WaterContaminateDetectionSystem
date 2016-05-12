function [ D ] = get_gaussian_distribution(sig,count)
%   生成高斯分布数据
%   sig：标准差
%   count: 生成高斯分布样本个数
    sig = 1/(sqrt(2*pi) * sig);
    low = -2 * sig;
    high = 2 * sig;
    step = (high - low) / count;
    x = low:step:high;
    x = x(2:end);
    D = normpdf(x,0,sig);
end

