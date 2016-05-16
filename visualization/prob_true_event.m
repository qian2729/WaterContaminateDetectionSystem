sigmas = [0.5 0.2];
addpath('../util');
for sigma = sigmas
    trained_svm = load(sprintf('svm_factor_%.1f.mat',sigma));
    factor = trained_svm.factor;
    test_data = trained_svm.test_data;
    TPR = trained_svm.TPR;
    FPR = trained_svm.FPR;
    test_label = trained_svm.test_label;
    alpha = 0.3;
    threshold = 0.9;
    predict_label = svmclassify(factor,test_data);
    [event_prediction,P_event] = bayes(predict_label, TPR,FPR,threshold,alpha);
    h = figure;
    b = bar(test_label,'FaceColor',[0.9 0.9 0.9]);
    hold on;
    plot(P_event);
    hold off;
    prefix = sprintf('概率和真实事件叠加图%.1f',sigma);
    title(prefix);
    savefig(strcat(prefix,'.fig'));
%     close h;
end
