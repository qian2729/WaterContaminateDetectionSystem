clc;
clear;

% FileNameEvents = 'data_with_low_events.txt';
% FileNameNormal = 'data_without_events.txt';
FileNameEvents = 'new_data.csv';
FileNameNormal = 'new_data_with_event.csv';
fprintf('step 1 加载训练和测试数据\n');
[ Xdata_events_train,Ydata_events_train,...
    Xdata_events_test,Ydata_events_test,...
    events_flag_train,events_flag_test,...
    Xdata_normal_train,Ydata_normal_train,...
    Xdata_normal_test,Ydata_normal_test] = load_data(FileNameEvents,FileNameNormal);

for sensor_type = 1:6
%     train_data_x = [Xdata_normal_train{sensor_type}' Xdata_normal_test{sensor_type}'];
%     train_data_y = [Ydata_normal_train{sensor_type}' Ydata_normal_test{sensor_type}'];
    train_data_x = Xdata_normal_train{sensor_type}';
    train_data_y = Ydata_normal_train{sensor_type}';
    [net] = train_ann( train_data_x, train_data_y );
    test_data_x = Xdata_normal_test{sensor_type}';
    test_data_y = Ydata_normal_test{sensor_type}';
    vis_ann_result(net,test_data_x,test_data_y)
    eval(['net' num2str(sensor_type) '=net;']);
end

save('new_train_ann.mat','net1','net2','net3','net4','net5','net6');

