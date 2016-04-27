function [ event_prediction ] = bayes(predict_label,TPR,FPR, threshold,alpha)
%   Ӧ�ñ�Ҷ˹�����ÿһʱ���¼������ĸ��ʽ��й���
%   ��Ӧ��ƽ��������ȥ�������¼�

    pe0 = 1e-5;                     %���ó�ʼ�¼��ĸ���
    if nargin < 4
        threshold = 0.9; % ����Ĭ����ֵ
        alpha = 0.3;    % ����Ĭ��ƽ��ϸ�� 0.3<��alpha<��0.9
    end  
                     
    pe = pe0;
    P_event = zeros(1,length(predict_label));
    for i=1:length(predict_label)    % ���ñ�Ҷ˹���¹�������¼��������ʵļ���
        if predict_label(i) == 1     % ��ǰ���ָ��Ϊ�쳣
            pe1=pe;
            pe=TPR*pe/(TPR*pe+FPR*(1-pe));   % Ӧ���쳣ָ��ĸ��¹���
            pe=alpha*pe+(1-alpha)*pe1;       % ƽ������
            pe=min(pe,0.95);                 % 
        else
            pe1=pe;
            pe=(1-TPR)*pe/((1-TPR)*pe+(1-FPR)*(1-pe));   %û���쳣�ĸ��¹���
            pe=alpha*pe+(1-alpha)*pe1;                
            pe=max(pe,pe0);                          
        end
        P_event(i)=pe;                           
    end                
    event_prediction=1*(P_event>=threshold);        %Classify
end

