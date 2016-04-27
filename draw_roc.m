function [] = draw_roc(model, factor, test_data,test_label,TPR, FPR)
%   »æÖÆROCÇúÏß
    thresholds = 0.1:0.05:1;
    tpr = zeros(length(thresholds));
    fpr = zeros(length(thresholds));
    index = 1;
    for threshold = thresholds
        [test_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold);
        [tp,fp] = get_TPR_FPR(test_label,test_prediction);
        tpr(index) = tp;
        fpr(index) = fp;
        index = index + 1;
    end
    figure
    plot(fpr,tpr);
    title('ROC');
end

