function [ event_data ] = add_event_to_data( data)
%   ��data����ӷ��ϸ�˹�ֲ���event
%   data: n * m; n Ϊsimple�������� mΪ��������������3:mÿһ��Ϊһ�ִ�����������
    [n,m] = size(data);
    step = 1056; % �����˶�ò���һ���¼�
    count = 96; % �����˸�˹�ֲ��¼��ĳ���ʱ��
    event_data = data;
    sigmas = ones(m,1);
    sigmas(:) = 0.21;
    [ signs ] = create_signs(step,count,n);
    for i = 3:m
        sig = std(data(:,i));
        simulate_data = get_fixed_event(n,step,count,sigmas(i) * sig,signs);
        simulate_pos = simulate_data > 0;
        event_data(:,i) = data(:,i) +  simulate_data;
        event_data(simulate_pos,2) = 1;
    end
end

