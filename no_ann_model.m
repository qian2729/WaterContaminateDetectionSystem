clc;
close all;
clear;

% step 0: 加载相关函数
% -----------------------------------------------------------------------------
addpath('data/');
addpath('ann/');
addpath('util/');
addpath('svm_model/');
addpath('evaluation/');

sigma_for_data = 0.5;
% step 1: 加载训练和测试数据
% -----------------------------------------------------------------------------
% event_path = 'new_data_with_event.csv';
event_path = sprintf('data/new_data_with_event_%.1f.csv',sigma_for_data);
fprintf('step 1 加载训练和测试数据\n');
event_data = load(event_path);
[train_data, test_data] = split_data_to_train_test(event_data);

% step 3: 将训练数据划分为训练集和验证集
% -----------------------------------------------------------------------------
fprintf('step 3 将训练数据划分为训练集和验证集\n');
split_count = 4;
split_index = 1;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 4: 用GA优化SVM参数C和sigma
% -----------------------------------------------------------------------------
fprintf('step 4 GA 优化C和sigma\n');
addpath('svm_model/');
[ C, sigma, TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label );

% step 5: 用训练数据训练SVM模型
% -----------------------------------------------------------------------------
fprintf('step 5 训练SVM模型\n');
factor = train_svm( train_data, train_label, C, sigma);

% save trained model for visualization
factor_file_name = sprintf('visualization/svm_factor_%.1f.mat',sigma_for_data);
save(factor_file_name,'factor','TPR','FPR','test_data','test_label');
% step 7: 用SVM模型做预测
% -----------------------------------------------------------------------------
fprintf('step 7 用SVM模型进行预测\n');
threshold = 0.9;
model = @svmclassify;
alpha = 0.1;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold,alpha);
% step 8: 对预测结果进行评估
% -----------------------------------------------------------------------------
fprintf('step 8 性能评定\n');
evaluation(test_label,test_prediction); %  画预测结果图
save(sprintf('visualization/fig/svm_predict_sigma%.1f.fig',sigma_for_data));

