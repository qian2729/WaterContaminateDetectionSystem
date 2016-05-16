function [ simulate_data ] = get_fixed_event( len, step, count, sig,signs )
%   ��ȡ�̶�����ĸ�˹�ֲ�����
%   len���������ݵĳ���
%   step:   ÿ�����ò�����˹�쳣�ֲ�������
%   count:  ÿ����˹�ֲ�����
%   sig:    ��˹�ֲ�����
    simulate_data = zeros(len,1);
    index = 1;
    for i = 100:step+count:len
        sign = signs(index);
        if(rand() > 0.75)
            sign = -sign;
        end
        simulate_data(i:i + count - 1) = sign * get_gaussian_distribution(sig, count); 
        index = index + 1;
    end
end

