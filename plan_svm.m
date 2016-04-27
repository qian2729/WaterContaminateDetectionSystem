clc;
close all;
clear;
% step 1: ����ѵ���Ͳ�������
% -----------------------------------------------------------------------------
fprintf('step 1 ����ѵ���Ͳ�������\n');
[ Xdata_events_train,Ydata_events_train,...
      Xdata_events_test,Ydata_events_test,...
      train_label,test_label ] = load_data();

% step 2: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
% -----------------------------------------------------------------------------
fprintf('step 2 ����ѵ�����ݼ��в�\n');
[ train_data ] = ann_predict_error( Xdata_events_train, Ydata_events_train );  % ѵ���������

% step 3: ����ѵ�����Ͳ��Լ�
% -----------------------------------------------------------------------------
fprintf('step 3 ����ѵ�����Ͳ��Լ�\n');
split_count = 10;
split_index = 7;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 3: ��ѵ������ѵ��SVMģ��
% -----------------------------------------------------------------------------
fprintf('step 3 ѵ��SVMģ��\n');
C = 1;
[ factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label, C);

% step 4: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
% -----------------------------------------------------------------------------
fprintf('step 4 ����������ݼ��в�\n');
[ test_data ] = ann_predict_error( Xdata_events_test, Ydata_events_test );  % �����������

% step 5: ��SVMģ����Ԥ��
% -----------------------------------------------------------------------------
fprintf('step 5 ��SVMģ�ͽ���Ԥ��\n');
threshold = 0.9;
model = @svmclassify;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold);

% step 6: ��Ԥ������������
% -----------------------------------------------------------------------------
fprintf('step 6 ��������\n');
% evaluation(test_label,test_prediction); �� ��Ԥ����ͼ
% draw_roc(model, factor, test_data,test_label,TPR, FPR); % ��ROCͼ

