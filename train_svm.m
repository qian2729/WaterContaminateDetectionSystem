function [ factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label,C,sigma)
%	ѵ��SVMģ��
%   return��
%           factor:SVMѵ������
    % level��C������svm_parameters_optimization�ű�ѡ����ʵĲ���
    factor = svmtrain(train_data, train_label,'boxconstraint',C, 'kernel_function','rbf','rbf_sigma',sigma);
    train_predict = svmclassify(factor, train_data);
    [TPR,FPR] = get_TPR_FPR( train_label, train_predict );
    validate_predict = svmclassify(factor, validate_data);
    [event_prediction ] = bayes(validate_predict, TPR,FPR);
    [TPR,FPR] = get_TPR_FPR( validate_label, event_prediction );
end

