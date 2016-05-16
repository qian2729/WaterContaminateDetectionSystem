% 指定不同的
sigmas = [0.2 0.5];
addpath('../util');

% prefix = 'svm';
% model = @svmclassify;
prefix = 'decision_tree';
model = @predict;
alpha = 0.5;
threshold = 0.9;

for sigma = sigmas
    model_name = sprintf('factor/factor_%s_%.1f.mat',prefix,sigma);
    trained_model = load(model_name);
    factor = trained_model.factor;
    test_data = trained_model.test_data;
    TPR = trained_model.TPR;
    FPR = trained_model.FPR;
    test_label = trained_model.test_label;
    predict_label = model(factor,test_data);
    [event_prediction,P_event] = bayes(predict_label, TPR,FPR,threshold,alpha);
    
    h = figure;
    bar(test_label,'FaceColor',[0.9 0.9 0.9]);
    hold on;
    plot(P_event);
    hold off;
    title_str = sprintf('%s prob and true label sigma-%.1f-alpha%.2f',prefix, sigma,alpha);
    title(title_str);
    savefig(sprintf('fig/prob_and_true_label_sigma%s_%.1f_alpha_%.2f.fig',prefix, sigma,alpha));
    close h;
end
