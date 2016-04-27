function [event_prediction] = make_predict( model, factor, test_data, TPR, FPR, threshold, alpha)
%PREDICT Summary of this function goes here
%   Detailed explanation goes here
    if nargin==6
        alpha = 0.25; %  Ä¬ÈÏÆ½»¬ãÐÖµ
    end  
    predict_label = model(factor,test_data);
    [event_prediction] = bayes(predict_label, TPR,FPR,threshold,alpha);
end

