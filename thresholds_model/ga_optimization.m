function [thresholds,TPR, FPR,alpha ] = ga_optimization( train_data, train_label )
%   ���Ŵ��㷨�Ż�Thresholds
    % �����Ŵ��㷨����
    %-------------------------------------------------------------------------
    options.Display='iter';                           %Display GA iterations 
    options.PlotFcns={@gaplotbestf @gaplotbestindiv}; %Display GA iterations graph
    options.PopulationSize=100;                        %Population size
    options.Generations=4;                           %Set number of generations
    options.TolFun=1e-6;                              %Set ending critiria
    options.CrossoverFcn=@crossoverheuristic;         %Set crossover type  Ⱦɫ�彻������
    options.FitnessScalingFcn=@fitscalingprop;        %Set scaling type  ��Ӧ�Ⱥ�����ϵͳ�Դ���
    options.MutationFcn= @mutationadaptfeasible;      %Set mutation type  ����
    options.SelectionFcn=@selectionroulette;          %Set selection type ѡ��������Ⱥ

    %  �����Ż����������½�
    %-------------------------------------------------------------------------
    % Block 5: Set low bounds and high bounds for GA x's values.�������Ŵ��㷨�����½�
    %-------------------------------------------------------------------------
    lb=[0.01*ones(1,6) 0.2]; %Lower bounds ...
    %  [threshold   alpha]
    ub=[2*ones(1,6) 0.9]; %Upper bounds
    
    % �Ż�2������
    %-------------------------------------------------------------------------
    % ����Ŀ�꺯��
    fun=@(x)fitness_fun(train_data, train_label,x(1:6),x(7));       
    xopt= ga(fun,7,[],[],[],[],lb,ub,[],options);          %����Ż�����
    [~, TPR,FPR,thresholds,alpha]=fun(xopt);                           %�����Ż����
end

