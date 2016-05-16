function [ C, sigma,TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label )
%   ���Ŵ��㷨�Ż�SVM��C��gama�Ĳ���
%   �����Ż������Cֵ��gamaֵ
    % �����Ŵ��㷨����
    %-------------------------------------------------------------------------
    options.Display='iter';                           %Display GA iterations 
    options.PlotFcns={@gaplotbestf @gaplotbestindiv}; %Display GA iterations graph
    options.PopulationSize=24;                        %Population size
    options.Generations=3;                           %Set number of generations
    options.TolFun=1e-6;                              %Set ending critiria
    options.CrossoverFcn=@crossoverheuristic;         %Set crossover type  Ⱦɫ�彻������
    options.FitnessScalingFcn=@fitscalingprop;        %Set scaling type  ��Ӧ�Ⱥ�����ϵͳ�Դ���
    options.MutationFcn= @mutationadaptfeasible;      %Set mutation type  ����
    options.SelectionFcn=@selectionroulette;          %Set selection type ѡ��������Ⱥ
%     options.UseParallel='always';                     %Set parallel computation mode  �������㣨���Զ��CPU���У�
    
    %  �����Ż����������½�
    %-------------------------------------------------------------------------
    lb=[0.1 0.1    0.1]; %�½�
    %  [C    sigma alpha]
    ub=[1    1     0.9]; %�Ͻ�
    
    % �Ż�2������
    %-------------------------------------------------------------------------
    % ����Ŀ�꺯��
    fun=@(x)fitness_fun(train_data, train_label,validate_data,validate_label,x(1),x(2),x(3));       
    xopt= ga(fun,3,[],[],[],[],lb,ub,[],options);          %����Ż�����
    [~, TPR,FPR,C,sigma]=fun(xopt);                           %�����Ż����
end
