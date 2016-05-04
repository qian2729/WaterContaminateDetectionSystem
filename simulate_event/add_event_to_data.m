function [ event_data ] = add_event_to_data( data)
%   向data中添加符合高斯分布的event
%   data: n * m; n 为simple的数量， m为传感器的数量，每一列为一种传感器的数据
    [n,m] = size(data);
    step = 1000; % 决定了多久产生一次事件
    count = 100; % 决定了高斯分布事件的持续时间
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

