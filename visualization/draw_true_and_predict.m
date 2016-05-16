% 打印不同模型在测试集上的输出结果

% svm
plot_true_and_predict('svm',@svmclassify,0.1);

% decision tree
plot_true_and_predict('decision_tree',@predict,0.1);

% no ann
plot_true_and_predict('no_ann_svm',@svmclassify,0.1);
% thresholds
plot_true_and_predict('thresholds',@thresholds_predict,0.1);