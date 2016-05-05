function [ D ] = get_gaussian_distribution(sig,count)
%   ���ɸ�˹�ֲ�����
%   sig����׼��
%   count: ���ɸ�˹�ֲ���������
    sig = 1/(sqrt(2*pi) * sig);
    low = -2 * sig;
    high = 2 * sig;
    step = (high - low) / count;
    x = low:step:high;
    x = x(2:end);
    D = normpdf(x,0,sig);
end

