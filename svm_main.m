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

sigmas = [0.2 0.5];
% sigmas = 0.2;
for sigma_for_data = sigmas
    % step 1: ����ѵ���Ͳ�������
    % -----------------------------------------------------------------------------
%     event_path = 'new_data_with_event.csv';
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
%     ann_model = 'ann/ann_model_old.mat' ;
    ann_model = 'ann/new_train_ann.mat';
    [ whole_train_data ] = ann_predict_error( train_X, train_Y,ann_model );  % ѵ���������

    % step 3: ��ѵ�����ݻ���Ϊѵ��������֤��
    % -----------------------------------------------------------------------------
    fprintf('step 3 ��ѵ�����ݻ���Ϊѵ��������֤��\n');
    split_count = 4;
    split_index = 1;
    [train_data, train_label, validate_data, validate_label ] = ...
                    split_train( whole_train_data, train_label, split_count, split_index );

    % step 4: ��GA�Ż�SVM����C��sigma
    % -----------------------------------------------------------------------------
    fprintf('step 4 GA �Ż�C��sigma\n');
    addpath('svm_model/');
    %%%%%%%%%%%%%%%
    % ����ѡ��õ�C��sigma��TPR��FPR���ݾ����������
    %%%%%%%%%%%%%%%%
%     alpha = 0.8;
%     [ C, sigma, TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label,alpha );
     C=0.85;
     sigma=0.60;
     TPR = 0.9;
     FPR = 0.01;
    % step 5: ��ѵ������ѵ��SVMģ��
    % -----------------------------------------------------------------------------
    fprintf('step 5 ѵ��SVMģ��\n');
    factor = train_svm( train_data, train_label, C, sigma);
    % step 6: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
    % -----------------------------------------------------------------------------
    fprintf('step 6 ����������ݼ��в�\n');
    [ test_data ] = ann_predict_error( test_X, test_Y,ann_model );  % �����������
    % save trained model for visualization
    factor_file_name = sprintf('visualization/factor/factor_svm_%.1f.mat',sigma_for_data);
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
    h = evaluation(test_label,test_prediction); %  ��Ԥ����ͼ
    savefig(sprintf('visualization/fig/predict_svm_sigma%.1f.fig',sigma_for_data));
    close(h);
end

