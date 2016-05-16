% 绘制不同模型的roc图

% svm model
plot_roc('svm',@svmclassify,0.2);
% decision tree model
plot_roc('decision_tree',@predict,0.6);

% no ann svm 
plot_roc('no_ann_svm',@svmclassify,0.2);

% thresholds
addpath('../thresholds_model/');
plot_roc('thresholds',@thresholds_predict,0.2);
