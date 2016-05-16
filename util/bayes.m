function [ event_prediction,P_event ] = bayes(predict_label,TPR,FPR, threshold, alpha)
%   应用贝叶斯规则对每一时刻事件发生的概率进行估计
%   并应用平滑方法来去除噪声事件 ,alpha

    pe0 = 1e-8;                     %设置初始事件的概率
%     alpha = 0.5;    % 设置默认平滑细数 0.1<＝alpha<＝0.9 通过修改平滑系数可以调整去掉噪音异常的程度
                     
    pe = pe0;
    P_event = zeros(1,length(predict_label));
    for i=1:length(predict_label)    % 利用贝叶斯更新规则进行事件发生概率的计算
        if predict_label(i) == 1     % 当前检测指标为异常
            pe1=pe;
            pe=TPR*pe/(TPR*pe+FPR*(1-pe));   % 应用异常指标的更新规则
            pe=alpha*pe+(1-alpha)*pe1;       % 平滑处理
            pe=min(pe,0.999999);             
        else
            pe1=pe;
            pe=(1-TPR)*pe/((1-TPR)*pe+(1-FPR)*(1-pe));   %没有异常的更新规则
            pe=alpha*pe+(1-alpha)*pe1;                
            pe=max(pe,pe0);                          
        end
        P_event(i)=pe;                           
    end                
    event_prediction = 1*(P_event>=threshold);
end

