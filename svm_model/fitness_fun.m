function [Z, TPR,FPR,C,sigma]=fitness_fun...
    (train_data,train_label,validate_data, validate_label,C,sigma,alpha)
    try
        factor = train_svm( train_data, train_label, C,sigma);
        train_predict = svmclassify(factor, train_data);
        [TPR,FPR] = get_TPR_FPR( train_label, train_predict );
        threshold = 0.9;
        
        model = @svmclassify;
        [validate_prediction] = make_predict( model, factor, validate_data,... 
                                                TPR, FPR, threshold,alpha);
        [ TPR, FPR ] = get_TPR_FPR( validate_label, validate_prediction );
        conf = confusionmat(validate_label,validate_prediction);
        accuracy = (conf(1,1) + conf(2,2)) / sum(sum(conf));
        Z = -(accuracy + TPR) + FPR; %优化目标
        fprintf('C:%.2f sigma:%.2f alpha:%.2f accuracy:%.2f,TPR:%.2f, FPR:%.2f Z:%.3f\n',... 
                                C,sigma, alpha, accuracy, TPR, FPR,Z);
    catch
        Z = 0.0;
        TPR = 0.0;
        FPR = 1.0;
        fprintf('C:%.2f sigma:%.2f svm unconvergence\n',C,sigma);
    end
    
end                       



