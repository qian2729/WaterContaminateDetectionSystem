function [ factor] = train_svm( train_data, train_label,C,sigma)
%	ѵ��SVMģ��
%   return��
%           factor:SVMѵ������
    factor = svmtrain(train_data, train_label,'boxconstraint',C, 'kernel_function','rbf','rbf_sigma',sigma);
end

