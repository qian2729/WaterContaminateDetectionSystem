clc;
close all;
clear;
% step 1: 加载训练和测试数据
% -----------------------------------------------------------------------------
% FileNameEvents = 'data_with_low_events.txt';
% FileNameNormal = 'data_without_events.txt';
FileNameEvents = 'new_data_with_event.csv';
FileNameNormal = 'new_data.csv';
fprintf('step 1 加载训练和测试数据\n');
[ Xdata_events_train,Ydata_events_train,...
      Xdata_events_test,Ydata_events_test,...
      train_label,test_label ] = load_data(FileNameEvents,FileNameNormal);

% step 2: 利用神经网络模型做预测，计算训练数据集预测与实际测量的误差
% -----------------------------------------------------------------------------
fprintf('step 2 计算训练数据集残差\n');
% ann_model = 'trained_neural_networks.mat' ;
ann_model = 'new_train_ann.mat';
[ train_data ] = ann_predict_error( Xdata_events_train, Ydata_events_train,ann_model );  % 训练数据误差

% step 3: 划分训练集和测试集
% -----------------------------------------------------------------------------
fprintf('step 3 划分训练集和测试集\n');
split_count = 4;
split_index = 1;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 4: 用GA优化SVM参数C和sigma
% -----------------------------------------------------------------------------
fprintf('step 4 GA 优化C和sigma\n');
% [ C, sigma, TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label );
C = 0.12;
sigma = 0.27;
% step 5: 用训练数据训练SVM模型
% -----------------------------------------------------------------------------
fprintf('step 5 训练SVM模型\n');
[ factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label, C, sigma);

% step 6: 利用神经网络模型做预测，计算训练数据集预测与实际测量的误差
% -----------------------------------------------------------------------------
fprintf('step 6 计算测试数据集残差\n');
[ test_data ] = ann_predict_error( Xdata_events_test, Ydata_events_test,ann_model );  % 测试数据误差

% step 7: 用SVM模型做预测
% -----------------------------------------------------------------------------
fprintf('step 7 用SVM模型进行预测\n');
threshold = 0.9;
model = @svmclassify;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold);

% step 8: 对预测结果进行评估
% -----------------------------------------------------------------------------
fprintf('step 8 性能评定\n');
evaluation(test_label,test_prediction); %  画预测结果图
% draw_roc(model, factor, test_data,test_label,TPR, FPR); % 画ROC图

