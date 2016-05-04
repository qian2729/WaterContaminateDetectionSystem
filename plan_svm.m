clc;
close all;
clear;
% step 1: ����ѵ���Ͳ�������
% -----------------------------------------------------------------------------
FileNameEvents = 'data_with_low_events.txt';
FileNameNormal = 'data_without_events.txt';
% FileNameEvents = 'new_data.csv';
% FileNameNormal = 'new_data_with_event.csv';
fprintf('step 1 ����ѵ���Ͳ�������\n');
[ Xdata_events_train,Ydata_events_train,...
      Xdata_events_test,Ydata_events_test,...
      train_label,test_label ] = load_data(FileNameEvents,FileNameNormal);

% step 2: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
% -----------------------------------------------------------------------------
fprintf('step 2 ����ѵ�����ݼ��в�\n');
[ train_data ] = ann_predict_error( Xdata_events_train, Ydata_events_train );  % ѵ���������

% step 3: ����ѵ�����Ͳ��Լ�
% -----------------------------------------------------------------------------
fprintf('step 3 ����ѵ�����Ͳ��Լ�\n');
split_count = 4;
split_index = 1;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 4: ��GA�Ż�SVM����C��sigma
% -----------------------------------------------------------------------------
fprintf('step 4 GA �Ż�C��sigma\n');
% [ C, sigma, TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label );
C = 0.64;
sigma = 0.7;
% step 5: ��ѵ������ѵ��SVMģ��
% -----------------------------------------------------------------------------
fprintf('step 5 ѵ��SVMģ��\n');
[ factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label, C, sigma);

% step 6: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
% -----------------------------------------------------------------------------
fprintf('step 6 ����������ݼ��в�\n');
[ test_data ] = ann_predict_error( Xdata_events_test, Ydata_events_test );  % �����������

% step 7: ��SVMģ����Ԥ��
% -----------------------------------------------------------------------------
fprintf('step 7 ��SVMģ�ͽ���Ԥ��\n');
threshold = 0.9;
model = @svmclassify;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold);

% step 8: ��Ԥ������������
% -----------------------------------------------------------------------------
fprintf('step 8 ��������\n');
evaluation(test_label,test_prediction); %  ��Ԥ����ͼ
draw_roc(model, factor, test_data,test_label,TPR, FPR); % ��ROCͼ

