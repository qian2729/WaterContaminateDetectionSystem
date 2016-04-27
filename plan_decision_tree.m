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
split_count = 4;
split_index = 3;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );

% step 3: ��ѵ������ѵ��SVMģ�ͣ�ģ�Ͳ������Ŵ�����svm_parameters_optimization�ű��У�
% -----------------------------------------------------------------------------
fprintf('step 3 ѵ��������ģ��\n');
[ factor,TPR,FPR ] = train_decision_tree( train_data, train_label,train_data,train_label);

% step 4: ����������ģ����Ԥ�⣬����ѵ�����ݼ�Ԥ����ʵ�ʲ��������
% -----------------------------------------------------------------------------
fprintf('step 4 ����������ݼ��в�\n');
[ test_data ] = ann_predict_error( Xdata_events_test, Ydata_events_test );  % �����������
% step 5: ��SVMģ����Ԥ��
% -----------------------------------------------------------------------------
fprintf('step 5 �þ�����ģ��ʶ��ÿ��ʱ���Ƿ�Ϊ�쳣��\n');
threshold = 0.9;
model = @predict;
[test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold);

% step 6: ��Ԥ������������
% -----------------------------------------------------------------------------
fprintf('step 6 ��������\n');
% evaluation(test_label,test_prediction);
draw_roc(model, factor, test_data,test_label,TPR, FPR);
