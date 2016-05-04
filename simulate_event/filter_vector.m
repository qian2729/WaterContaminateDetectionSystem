function [ new_vector ] = filter_vector( vector )
%   �����ݽ��й��ˣ�ȥ��-3sigma ~ 3sigma �� mean֮�������
%   
    m = mean(vector);
    sig = std(vector);
    low = -3 * sig + m;
    high = 3 * sig + m;
    new_vector = vector(vector <= high & vector >= low);
end

