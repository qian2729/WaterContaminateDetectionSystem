function [Z, TPR,FPR,thresholds,alpha]=fitness_fun(train_data,train_label,thresholds,alpha)
% ��ͬ��ֵ�õ���׼ȷ�ʺ�TPR��FPR

    predict_label = thresholds_predict(thresholds,train_data);

    [TPR,FPR] = get_TPR_FPR( train_label, predict_label );
    threshold = 0.9;
    [event_prediction] = bayes(predict_label, TPR,FPR,threshold,alpha);
    conf = confusionmat(train_label,event_prediction);
    accuracy = (conf(1,1) + conf(2,2)) / sum(sum(conf));
    Z = -(accuracy + TPR) + FPR; %�Ż�Ŀ��
    fprintf('accuracy %.2f TPR %.2f FPR %.2f Z:%.3f\n',accuracy, TPR, FPR,Z);
end                       



