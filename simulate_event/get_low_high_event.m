function [ simulate_data ] = get_low_high_event( len, step, count, low_sig,high_sig )
%   ��ȡ�̶�����ĸ�˹�ֲ�����
%   len���������ݵĳ���
%   step:   ÿ�����ò�����˹�쳣�ֲ�������
%   count:  ÿ����˹�ֲ�����
%   sig:    ��˹�ֲ�����
    simulate_data = zeros(len,1);
    
    for i = 1:step+count:len
        sign = randsrc(1,1,[-1,1]); % ѡ���˹�ֲ��ķ���������
        sig = randsrc(1,1,[-1,1]);
        % ���ѡ���sigma��event���ߵ�sigma��event
        if sig == 1
           dis = get_gaussian_distribution(low_sig, count);
        else
           dis = get_gaussian_distribution(high_sig, count);
        end
        simulate_data(i:i + count - 1) = sign * dis; 
    end
end