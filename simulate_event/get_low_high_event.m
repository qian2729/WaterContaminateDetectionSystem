function [ simulate_data ] = get_low_high_event( len, step, count, low_sig,high_sig )
%   获取固定方差的高斯分布数据
%   len：生成数据的长度
%   step:   每间隔多久产生高斯异常分布的数据
%   count:  每个高斯分布数量
%   sig:    高斯分布方差
    simulate_data = zeros(len,1);
    
    for i = 1:step+count:len
        sign = randsrc(1,1,[-1,1]); % 选择高斯分布的方向（正负）
        sig = randsrc(1,1,[-1,1]);
        % 随机选择高sigma的event或者低sigma的event
        if sig == 1
           dis = get_gaussian_distribution(low_sig, count);
        else
           dis = get_gaussian_distribution(high_sig, count);
        end
        simulate_data(i:i + count - 1) = sign * dis; 
    end
end