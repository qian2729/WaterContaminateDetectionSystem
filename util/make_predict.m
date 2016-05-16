function [event_prediction,P_event] = make_predict( model, factor, test_data, TPR, FPR, threshold, alpha)
%   ���ݴ����ģ�ͣ�Ԥ��ÿһʱ���¼��Ƿ���
%   
    predict_label = model(factor,test_data);
    [event_prediction,P_event] = bayes(predict_label, TPR,FPR,threshold,alpha);
end

