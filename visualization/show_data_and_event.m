
normal_data = load('../data/new_data.csv');
event_data = load('../data/new_data_with_event.csv');
start_pos = 12001;
end_pos = 22000;
sensor_type = 3; % 3~8

for sensor_type = 3:8
    len = end_pos - start_pos + 1;
    xData = start_pos:end_pos;
    h = figure;
    subplot(311)
    plot(xData,normal_data(start_pos:end_pos,sensor_type),'b');
    title(strcat('sensor type ',num2str(sensor_type)));
    subplot(312)
    plot(xData,event_data(start_pos:end_pos, sensor_type),'r');
    subplot(313)
    plot(xData,event_data(start_pos:end_pos, sensor_type),'r');
    hold on;
    plot(xData,normal_data(start_pos:end_pos,sensor_type),'b');
    hold off;
    filename = sprintf('fig/data_and_event_sensor%d.fig',sensor_type);
    savefig(filename);
    close(h);
end


