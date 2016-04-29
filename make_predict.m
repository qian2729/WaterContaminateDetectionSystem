function [event_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold)
%PREDICT Summary of this function goes here
%   Detailed explanation goes here
    predict_label = model(factor,test_data);
    [event_prediction] = bayes(predict_label, TPR,FPR,threshold);
end

