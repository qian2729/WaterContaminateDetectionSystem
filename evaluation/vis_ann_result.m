function [] = vis_ann_result(net,test_data_x,test_data_y)
%   ��ʾANN��ѵ��Ч��
%   Detailed explanation goes here
    figure;
    predict_y = sim(net,test_data_x);                %������� 
    x = 1:length(test_data_y);
    y_range = minmax(test_data_y);
    subplot(311);
    plot(x,test_data_y);
    title('��׼���');
    subplot(312);
    plot(x,predict_y);
    title('Ԥ�����');
    ylim(y_range);
    subplot(313);
    plot(x,predict_y - test_data_y);
    title('Ԥ�����');
    ylim(y_range);
end

