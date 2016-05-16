% 画正常和添加异常之后的对比图

sigmas = [0.2, 0.5];
start_pos = 12001;
end_pos = 22000;
normal_data = load('../data/new_data.csv');

for sensor_type = 3:8
    h = figure;
    subplot(3,1,1);
    sensor_data = normal_data(start_pos:end_pos,sensor_type);
    plot(sensor_data,'b');
    title(sprintf('normal data sensor type %d',sensor_type));
    index = 2;
    for sigma = sigmas
        event_file = sprintf('../data/new_data_with_event_%.1f.csv',sigma);
        event_data = load(event_file);
        event_sensor_data = event_data(start_pos:end_pos,sensor_type);
        subplot(3,1,index);
        index = index + 1;
        plot(event_sensor_data,'r');
        hold on;
        plot(sensor_data,'b');
        hold off;
        t = sprintf('sigma %.1f',sigma);
        title(t);
    end
    filename = sprintf('fig/normal_event_data_sensor_type%d.fig',sensor_type);
    savefig(filename);
    close(h);
end


