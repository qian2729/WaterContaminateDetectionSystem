function [ new_vector ] = filter_vector( vector )
%   对数据进行过滤，去除-3sigma ~ 3sigma ＋ mean之外的数据
%   
    m = mean(vector);
    sig = std(vector);
    low = -3 * sig + m;
    high = 3 * sig + m;
    new_vector = vector(vector <= high & vector >= low);
end

