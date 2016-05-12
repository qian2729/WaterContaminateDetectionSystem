function [ factor] = train_svm( train_data, train_label,C,sigma)
%	训练SVM模型
%   return：
%           factor:SVM训练参数
    factor = svmtrain(train_data, train_label,'boxconstraint',C, 'kernel_function','rbf','rbf_sigma',sigma);
end

