function [ event_data ] = add_event_to_data( data)
%   向data中添加符合高斯分布的event
%   data: n * m; n 为simple的数量， m为传感器的数量，3:m每一列为一种传感器的数据
    [n,m] = size(data);
    step = 1056; % 决定了多久产生一次事件
    count = 96; % 决定了高斯分布事件的持续时间
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

