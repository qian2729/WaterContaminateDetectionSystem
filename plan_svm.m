clc;
close all;
clear;
% step 1: 加载训练和测试数据
% -----------------------------------------------------------------------------
fprintf('step 1 加载训练和测试数据\n');
[ Xdata_events_train,Ydata_events_train,...
      Xdata_events_test,Ydata_events_test,...
      train_label,test_label ] = load_data();

% step 2: 利用神经网络模型做预测，计算训练数据集预测与实际测量的误差
% -----------------------------------------------------------------------------
fprintf('step 2 计算训练数据集残差\n');
[ train_data ] = ann_predict_error( Xdata_events_train, Ydata_events_train );  % 训练数据误差

% step 3: 划分训练集和测试集
% -----------------------------------------------------------------------------
fprintf('step 3 划分训练集和测试集\n');
split_count = 10;
split_index = 7;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 3: 用训练数据训练SVM模型
% -----------------------------------------------------------------------------
fprintf('step 3 训练SVM模型\n');
C = 1;
[ factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label, C);

% step 4: 利用神经网络模型做预测，计算训练数据集预测与实际测量的误差
% -----------------------------------------------------------------------------
fprintf('step 4 计算测试数据集残差\n');
[ test_data ] = ann_predict_error( Xdata_events_test, Ydata_events_test );  % 测试数据误差

% step 5: 用SVM模型做预测
% -----------------------------------------------------------------------------
fprintf('step 5 用SVM模型进行预测\n');
threshold = 0.9;
model = @svmclassify;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold);

% step 6: 对预测结果进行评估
% -----------------------------------------------------------------------------
fprintf('step 6 性能评定\n');
% evaluation(test_label,test_prediction); ％ 画预测结果图
% draw_roc(model, factor, test_data,test_label,TPR, FPR); % 画ROC图

