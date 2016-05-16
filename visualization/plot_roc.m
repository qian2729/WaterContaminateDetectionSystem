sigmas = [0.2 0.5];
addpath('../util');

for sigma = sigmas
    trained_svm = load(sprintf('svm_factor_%.1f.mat',sigma));
    factor = trained_svm.factor;
    test_data = trained_svm.test_data;
    TPR = trained_svm.TPR;
    FPR = trained_svm.FPR;
    test_label = trained_svm.test_label;
    alpha = 0.1;
    threshold = 0.9;
    h = figure;
    model = @svmclassify;
    [fpr,tpr] = get_roc(model, factor, test_data,test_label,TPR, FPR,alpha);
    plot(fpr,tpr);
    prefix = sprintf('ROC sigma-%.1f-alpha%.2f',sigma,alpha);
    title(prefix);
    savefig(sprintf('ROC_sigma%.1f_alpha_%.2f.fig',sigma,alpha));
%     close h;
end
