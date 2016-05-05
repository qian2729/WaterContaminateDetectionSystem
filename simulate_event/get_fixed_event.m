function [ simulate_data ] = get_fixed_event( len, step, count, sig )
%   ��ȡ�̶�����ĸ�˹�ֲ�����
%   len���������ݵĳ���
%   step:   ÿ�����ò�����˹�쳣�ֲ�������
%   count:  ÿ����˹�ֲ�����
%   sig:    ��˹�ֲ�����
    simulate_data = zeros(len,1);
    
    for i = 110:step+count:len
        sign = randsrc(1,1,[-1,1]);
        simulate_data(i:i + count - 1) = sign * get_gaussian_distribution(sig, count); 
    end
end

