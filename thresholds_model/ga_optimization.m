function [thresholds,TPR, FPR,alpha ] = ga_optimization( train_data, train_label )
%   用遗传算法优化Thresholds
    % 设置遗传算法参数
    %-------------------------------------------------------------------------
    options.Display='iter';                           %Display GA iterations 
    options.PlotFcns={@gaplotbestf @gaplotbestindiv}; %Display GA iterations graph
    options.PopulationSize=100;                        %Population size
    options.Generations=4;                           %Set number of generations
    options.TolFun=1e-6;                              %Set ending critiria
    options.CrossoverFcn=@crossoverheuristic;         %Set crossover type  染色体交叉运算
    options.FitnessScalingFcn=@fitscalingprop;        %Set scaling type  适应度函数（系统自带）
    options.MutationFcn= @mutationadaptfeasible;      %Set mutation type  变异
    options.SelectionFcn=@selectionroulette;          %Set selection type 选择优势种群

    %  设置优化参数的上下届
    %-------------------------------------------------------------------------
    % Block 5: Set low bounds and high bounds for GA x's values.％设置遗传算法的上下界
    %-------------------------------------------------------------------------
    lb=[0.01*ones(1,6) 0.2]; %Lower bounds ...
    %  [threshold   alpha]
    ub=[2*ones(1,6) 0.9]; %Upper bounds
    
    % 优化2个变量
    %-------------------------------------------------------------------------
    % 定义目标函数
    fun=@(x)fitness_fun(train_data, train_label,x(1:6),x(7));       
    xopt= ga(fun,7,[],[],[],[],lb,ub,[],options);          %解决优化问题
    [~, TPR,FPR,thresholds,alpha]=fun(xopt);                           %评估优化结果
end

