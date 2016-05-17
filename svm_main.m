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

sigmas = [0.2 0.5];
% sigmas = 0.2;
for sigma_for_data = sigmas
    % step 1: 加载训练和测试数据
    % -----------------------------------------------------------------------------
%     event_path = 'new_data_with_event.csv';
    event_path = sprintf('data/new_data_with_event_%.1f.csv',sigma_for_data);
    fprintf('step 1 加载训练和测试数据\n');
    event_data = load(event_path);
    [train_data, test_data] = split_data_to_train_test(event_data);
    [train_X,train_Y, train_label] = convert_data_to_ann_input(train_data);
    [test_X, test_Y, test_label] = convert_data_to_ann_input(test_data);
    clear train_data test_data;

    % step 2: 利用神经网络模型做预测，计算训练数据集预测与实际测量的误差
    % -----------------------------------------------------------------------------
    fprintf('step 2 计算训练数据集残差\n');
%     ann_model = 'ann/ann_model_old.mat' ;
    ann_model = 'ann/new_train_ann.mat';
    [ whole_train_data ] = ann_predict_error( train_X, train_Y,ann_model );  % 训练数据误差

    % step 3: 将训练数据划分为训练集和验证集
    % -----------------------------------------------------------------------------
    fprintf('step 3 将训练数据划分为训练集和验证集\n');
    split_count = 4;
    split_index = 1;
    [train_data, train_label, validate_data, validate_label ] = ...
                    split_train( whole_train_data, train_label, split_count, split_index );

    % step 4: 用GA优化SVM参数C和sigma
    % -----------------------------------------------------------------------------
    fprintf('step 4 GA 优化C和sigma\n');
    addpath('svm_model/');
    %%%%%%%%%%%%%%%
    % 利用选择好的C和sigma，TPR和FPR根据经验进行设置
    %%%%%%%%%%%%%%%%
%     alpha = 0.8;
%     [ C, sigma, TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label,alpha );
     C=0.85;
     sigma=0.60;
     TPR = 0.9;
     FPR = 0.01;
    % step 5: 用训练数据训练SVM模型
    % -----------------------------------------------------------------------------
    fprintf('step 5 训练SVM模型\n');
    factor = train_svm( train_data, train_label, C, sigma);
    % step 6: 利用神经网络模型做预测，计算训练数据集预测与实际测量的误差
    % -----------------------------------------------------------------------------
    fprintf('step 6 计算测试数据集残差\n');
    [ test_data ] = ann_predict_error( test_X, test_Y,ann_model );  % 测试数据误差
    % save trained model for visualization
    factor_file_name = sprintf('visualization/factor/factor_svm_%.1f.mat',sigma_for_data);
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
    h = evaluation(test_label,test_prediction); %  画预测结果图
    savefig(sprintf('visualization/fig/predict_svm_sigma%.1f.fig',sigma_for_data));
    close(h);
end

