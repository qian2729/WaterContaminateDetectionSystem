function [] = plot_true_and_predict(model_name,model,alpha)
%	���ݸ�����ģ�����ƣ�����ѵ���õ�ģ�ͣ������ڲ��������ϵ�Ԥ����
%  
    threshold = 0.9;
    sigmas = [0.2 0.5];
    addpath('../util');
    addpath('../evaluation');
    
    for sigma = sigmas
        factor_name = sprintf('factor/factor_%s_%.1f.mat', model_name,sigma);
        trained_model = load(factor_name);
        factor = trained_model.factor;
        test_data = trained_model.test_data;
        test_label = trained_model.test_label;
        TPR = trained_model.TPR;
        FPR = trained_model.FPR;
        [test_prediction,P_event] = make_predict( model, factor, test_data, TPR, FPR, threshold,alpha);
        h = figure;
        bar(test_label,'FaceColor',[0.5 0.5 0.5]);
        hold on;
        plot(P_event,'b');
        title(sprintf('true and predict %s-%.1f',model_name, sigma));
        savefig(sprintf('fig/true_and_predict_prob_%s_%.1f.fig',model_name,sigma));
        close(h);
        h = evaluation(test_label,test_prediction); %  ��Ԥ����ͼ
        savefig(sprintf('fig/predict_%s_sigma%.1f.fig',model_name,sigma));
        close(h);
    end
end

