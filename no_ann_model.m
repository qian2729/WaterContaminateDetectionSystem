clc;
close all;
clear;

% step 0: ������غ���
% -----------------------------------------------------------------------------
addpath('data/');
addpath('ann/');
addpath('util/');
addpath('svm_model/');
addpath('evaluation/');

sigma_for_data = 0.5;
% step 1: ����ѵ���Ͳ�������
% -----------------------------------------------------------------------------
% event_path = 'new_data_with_event.csv';
event_path = sprintf('data/new_data_with_event_%.1f.csv',sigma_for_data);
fprintf('step 1 ����ѵ���Ͳ�������\n');
event_data = load(event_path);
[train_data, test_data] = split_data_to_train_test(event_data);

% step 3: ��ѵ�����ݻ���Ϊѵ��������֤��
% -----------------------------------------------------------------------------
fprintf('step 3 ��ѵ�����ݻ���Ϊѵ��������֤��\n');
split_count = 4;
split_index = 1;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 4: ��GA�Ż�SVM����C��sigma
% -----------------------------------------------------------------------------
fprintf('step 4 GA �Ż�C��sigma\n');
addpath('svm_model/');
[ C, sigma, TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label );

% step 5: ��ѵ������ѵ��SVMģ��
% -----------------------------------------------------------------------------
fprintf('step 5 ѵ��SVMģ��\n');
factor = train_svm( train_data, train_label, C, sigma);

% save trained model for visualization
factor_file_name = sprintf('visualization/svm_factor_%.1f.mat',sigma_for_data);
save(factor_file_name,'factor','TPR','FPR','test_data','test_label');
% step 7: ��SVMģ����Ԥ��
% -----------------------------------------------------------------------------
fprintf('step 7 ��SVMģ�ͽ���Ԥ��\n');
threshold = 0.9;
model = @svmclassify;
alpha = 0.1;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold,alpha);
% step 8: ��Ԥ������������
% -----------------------------------------------------------------------------
fprintf('step 8 ��������\n');
evaluation(test_label,test_prediction); %  ��Ԥ����ͼ
save(sprintf('visualization/fig/svm_predict_sigma%.1f.fig',sigma_for_data));

