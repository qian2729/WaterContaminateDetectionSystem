% 在正常数据中添加异常数据的脚本

sigmas = [0.2, 0.5];

for sigma = sigmas
    new_data = load('../data/new_data.csv');
    [event_data ] = add_event_to_data(new_data,sigma);
    outfile = sprintf('../data/new_data_with_event_%.1f.csv',sigma);
    dlmwrite(outfile, event_data, ',');
end
