clc;
close all;
clear;

% step 0: ������غ���
% -----------------------------------------------------------------------------
addpath('data/');
addpath('ann/');
addpath('util/');
addpath('evaluation/');

sigmas = [0.2 0.5];

for sigma_for_data = sigmas
    % step 1: ����ѵ���Ͳ�������
    % -----------------------------------------------------------------------------
    event_path = sprintf('data/new_data_with_event_%.1f.csv',sigma_for_data);
    fprintf('step 1 ����ѵ���Ͳ�������\n');
    event_data = load(event_path);
    [train_data, test_data] = split_data_to_train_test(event_data);
    [train_X,train_Y, train_label] = convert_data_to_ann_input(train_data);
    [test_X, test_Y, test_label] = convert_data_to_ann_input(test_data);
    clear train_data test_data;

    % step 2: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
    % -----------------------------------------------------------------------------
    fprintf('step 2 ����ѵ�����ݼ��в�\n');
    ann_model = 'ann/new_train_ann.mat';
    [ train_data ] = ann_predict_error( train_X, train_Y,ann_model );  % ѵ���������

    % step 3: ��GA�Ż�thresholds
    % -----------------------------------------------------------------------------
    fprintf('step 3 GA �Ż�threshold\n');
    addpath('thresholds_model/');
    [ factor, TPR, FPR ] = ga_optimization(  train_data, train_label );

    
    % step 4: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
    % -----------------------------------------------------------------------------
    fprintf('step 4 ����������ݼ��в�\n');
    [ test_data ] = ann_predict_error( test_X, test_Y,ann_model );  % �����������
    % save trained model for visualization
    factor_file_name = sprintf('visualization/factor/factor_thresholds_%.1f.mat',sigma_for_data);
    save(factor_file_name,'factor','TPR','FPR','test_data','test_label');
    % step 5: ��thresholds ��Ԥ��
    % -----------------------------------------------------------------------------
    fprintf('step 5 ����ֵģ�ͽ���Ԥ��\n');
    threshold = 0.9;
    alpha = 0.3;
    model = @thresholds_predict;
    [test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold,alpha);
   
    % step 6: ��Ԥ������������
    % -----------------------------------------------------------------------------
    fprintf('step 6 ��������\n');
    h = evaluation(test_label,test_prediction); %  ��Ԥ����ͼ
    savefig(sprintf('visualization/fig/predict_thresholds_sigma%.1f.fig',sigma_for_data));
    close(h);
end

