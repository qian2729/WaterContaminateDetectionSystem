function [ event_data ] = add_event_to_data( data)
%   ��data����ӷ��ϸ�˹�ֲ���event
%   data: n * m; n Ϊsimple�������� mΪ��������������ÿһ��Ϊһ�ִ�����������
    [n,m] = size(data);
    step = 1000; % �����˶�ò���һ���¼�
    count = 100; % �����˸�˹�ֲ��¼��ĳ���ʱ��
    event_data = data;
    sigmas = ones(m,1);
    sigmas(4) = 0.5;
    sigmas(5) = 2;
    for i = 3:m-1
        sig = std(filter_vector(data(:,i)));
        simulate_data = get_fixed_event(n,step,count,sigmas(i) * sig);
        simulate_pos = simulate_data > 0;
        event_data(:,i) = data(:,i) +  simulate_data;
        event_data(simulate_pos,2) = 1;
    end
    event_data(:,m-1) = data(:,m-1) + get_low_high_event(n,step,count,4 * sig, 2 * sig);
end

