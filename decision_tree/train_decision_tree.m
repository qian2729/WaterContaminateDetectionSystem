function [factor,TPR,FPR ] = train_decision_tree( train_data, train_label,validate_data,validate_label,threshold,alpha )
%   train decision tree model with train data
%   
    factor = fitctree(train_data, train_label);
    train_predict = predict(factor,train_data);
    [TPR,FPR] = get_TPR_FPR( train_label, train_predict );
    predict_label = predict(factor,validate_data);
    [event_prediction ] = bayes(predict_label, TPR,FPR,threshold,alpha);
    [TPR,FPR] = get_TPR_FPR( validate_label, event_prediction );
end

