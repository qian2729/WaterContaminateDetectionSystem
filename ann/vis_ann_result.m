function [] = vis_ann_result(net,test_data_x,test_data_y)
%   显示ANN的训练效果
%   Detailed explanation goes here
    figure;
    predict_y = sim(net,test_data_x);                %网络仿真 
    x = 1:length(test_data_y);
    y_range = minmax(test_data_y);
    subplot(311);
    plot(x,test_data_y);
    title('标准输出');
    subplot(312);
    plot(x,predict_y);
    title('预测输出');
    ylim(y_range);
    subplot(313);
    plot(x,predict_y - test_data_y);
    title('预测误差');
    ylim(y_range);
end

