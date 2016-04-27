function [ factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label,C)
%	训练SVM模型
%   return：
%           factor:SVM训练参数
    
    % level和C都利用svm_parameters_optimization脚本选择合适的参数
    level = 0.4;
    factor = svmtrain(train_data, train_label,'KKTViolationLevel',level,'boxconstraint',C, 'kernel_function','rbf');
    train_predict = svmclassify(factor, train_data);
    [TPR,FPR] = get_TPR_FPR( train_label, train_predict );
    validate_predict = svmclassify(factor, validate_data);
    [event_prediction ] = bayes(validate_predict, TPR,FPR);
    [TPR,FPR] = get_TPR_FPR( validate_label, event_prediction );
end

