
sigmas = [0.2, 0.5];
start_pos = 12001;
end_pos = 22000;
normal_data = load('../data/new_data.csv');
sensor_type = 3;
sensor_data = normal_data(start_pos:end_pos,sensor_type);
h = figure;
subplot(3,1,1);
plot(sensor_data,'b');
title('normal data');
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
    t = sprintf('event %.1f',sigma);
    title(t);
end
filename = 'fig/different_event.fig';
savefig(filename);
close(h);



