% 对SVM的参数进行优化
clc;
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

% step 2: 将训练数据划分成4份其中一份做验证，其他3份做训练
% -----------------------------------------------------------------------------
fprintf('step 3 划分训练集和测试集\n');
split_count = 4;
split_index = 4;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index );
   
% C = [];
% for i = -5:10
%    C = [C 2^(i)]; 
% end
C = 1:10:100;
count = 0;
effects = zeros(length(C),2,'single');
for c = C
    count = count + 1;
    [factor,TPR,FPR] = train_svm( train_data, train_label,validate_data,validate_label, c);
    threshold = 0.9;
    model = @svmclassify;
    [validate_prediction] = predict( model, factor, validate_data, TPR, FPR, threshold);
    conf = confusionmat(validate_label,validate_prediction);
    accuracy = (conf(1,1) + conf(2,2)) / sum(sum(conf));
    TPR = conf(2,2) / sum(conf(2,:));
    FPR = conf(1,2) / sum(conf(1,:));
    true_event = validate_prediction & validate_label';
    detected_event = 0;
    for i = 2:length(true_event)
       if(true_event(i) > true_event(i-1))
           detected_event = detected_event + 1;
       end
    end
    effects(count, 1) = accuracy;
    effects(count, 2) = detected_event;
    fprintf('C : %.2f accurary:%.2f detected_event:%d\n',c, accuracy, detected_event);
end
figure;
subplot(311);
bar(effects(:,1));
title('accuracy');
subplot(312);
bar(effects(:,2));
title('detected event count');
subplot(313);
bar(C);
for i = 1:length(C)
    text(i,C(i)+2,num2str(C(i)));
end

title('C value');




