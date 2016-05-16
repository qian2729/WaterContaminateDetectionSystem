sigmas = [0.2 0.5];
addpath('../util');
% prefix = 'svm';
% model = @svmclassify;
prefix = 'decision_tree';
model = @predict;
alpha = 0.2;
threshold = 0.9;

for sigma = sigmas
    factor_name = sprintf('%s_factor_%.1f.mat', prefix,sigma);
    trained_model = load(factor_name);
    factor = trained_model.factor;
    test_data = trained_model.test_data;
    TPR = trained_model.TPR;
    FPR = trained_model.FPR;
    test_label = trained_model.test_label;
    h = figure;
    [fpr,tpr] = get_roc(model, factor, test_data,test_label,TPR, FPR,alpha);
    plot(fpr,tpr);
    title_str = sprintf('%s ROC sigma-%.1f-alpha%.2f',prefix, sigma,alpha);
    title(title_str);
    savefig(sprintf('fig/%s_ROC_sigma%.1f_alpha_%.2f.fig',prefix, sigma,alpha));
%     close h;
end
