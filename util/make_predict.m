function [event_prediction,P_event] = make_predict( model, factor, test_data, TPR, FPR, threshold, alpha)
%   根据传入的模型，预测每一时刻事件是否发生
%   
    predict_label = model(factor,test_data);
    [event_prediction,P_event] = bayes(predict_label, TPR,FPR,threshold,alpha);
end

