function [ signs ] = create_signs(step,count,len)
%   生成高斯分布的正负号
%   
    signs = [];
    index  = 1;
    for i = 100:step+count:len
        signs(index) = randsrc(1,1,[-1,1]);
        index = index + 1;
    end
end

