function [Z, TPR,FPR,C,sigma]=offline...
    (train_data,train_label,validate_data, validate_label,C,sigma)

    [factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label, C,sigma);
    threshold = 0.9;
    model = @svmclassify;
    [validate_prediction] = make_predict( model, factor, validate_data, TPR, FPR, threshold);
    [ TPR, FPR ] = get_TPR_FPR( validate_label, validate_prediction );
    conf = confusionmat(validate_label,validate_prediction);
    accuracy = (conf(1,1) + conf(2,2)) / sum(sum(conf));
    Z = -accuracy; %优化目标
    fprintf('C:%.2f sigma:%.2f accuracy:%.2f,TPR:%.2f, FPR:%.2f\n', C,sigma,accuracy, TPR, FPR);
end                       



