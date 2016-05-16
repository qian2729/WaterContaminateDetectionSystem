function [ predict_label ] = thresholds_predict(thresholds,train_data)
%   predict anomalous label with thresholds using voting methods

        predict_label = zeros(size(train_data,1),1);
        % 根据每个参数的阈值，计算每个时刻是否发生异常
        for sensor_type = 1:size(train_data,2)
            sensor_data = train_data(:,sensor_type);
            predict_label = predict_label + (sensor_data > thresholds(sensor_type));
        end
        % voting for event
        voting_threshold = 1;
        % plus 0 to convert logical to double
        predict_label = (predict_label >= voting_threshold) + 0; 
end

