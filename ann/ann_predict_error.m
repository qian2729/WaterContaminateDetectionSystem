function [ err ] = ann_predict_error( Xdata, Ydata, ann_model )
%   利用神经网络模型做预测，计算预测的误差
%   
    load (ann_model)
    for i=1:6
        eval(['Model=net' num2str(i) ';']);             %Choose the specific parameter network.
        err{i}=sim(Model,Xdata{i}')' - Ydata{i};        %Calculate the errors
    end
    err = cell2mat(err);
end

