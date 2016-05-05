function [ simulate_data ] = get_fixed_event( len, step, count, sig )
%   获取固定方差的高斯分布数据
%   len：生成数据的长度
%   step:   每间隔多久产生高斯异常分布的数据
%   count:  每个高斯分布数量
%   sig:    高斯分布方差
    simulate_data = zeros(len,1);
    
    for i = 110:step+count:len
        sign = randsrc(1,1,[-1,1]);
        simulate_data(i:i + count - 1) = sign * get_gaussian_distribution(sig, count); 
    end
end

