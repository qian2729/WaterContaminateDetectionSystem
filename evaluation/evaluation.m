function [  ] = evaluation( true_label, predict_label )
%   对预测结果进行可视化
%   
    figure
    subplot(211)
    bar(true_label);
    title('真实事件');
    subplot(212)
    bar(predict_label);
    title('预测事件');
end

