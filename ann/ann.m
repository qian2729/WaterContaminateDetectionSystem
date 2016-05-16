clc;
clear;

addpath('../data/');

normal_path = 'data/new_data.csv';
fprintf('step 1 加载训练和测试数据\n');
normal_data = load(normal_path);
[train_data, test_data] = split_data_to_train_test(normal_data);
[train_X,train_Y, train_label] = convert_data_to_ann_input(train_data);
[test_X, test_Y, test_label] = convert_data_to_ann_input(test_data);


for sensor_type = 1:6
    train_data_x = train_X{sensor_type}';
    train_data_y = train_Y{sensor_type}';
    [net] = train_ann( train_data_x, train_data_y );
    test_data_x = test_X{sensor_type}';
    test_data_y = test_Y{sensor_type}';
    vis_ann_result(net,test_data_x,test_data_y)
    eval(['net' num2str(sensor_type) '=net;']);
end

save('new_train_ann.mat','net1','net2','net3','net4','net5','net6');

