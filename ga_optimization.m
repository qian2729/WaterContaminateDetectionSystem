function [ C, sigma,TPR, FPR ] = ga_optimization(  train_data, train_label,validate_data,validate_label )
%   用遗传算法优化SVM的C和gama的参数
%   返回优化结果的C值和gama值
    % 设置遗传算法参数
    %-------------------------------------------------------------------------
    options.Display='iter';                           %Display GA iterations 
    options.PlotFcns={@gaplotbestf @gaplotbestindiv}; %Display GA iterations graph
    options.PopulationSize=4;                        %Population size
    options.Generations=3;                           %Set number of generations
    options.TolFun=1e-6;                              %Set ending critiria
    options.CrossoverFcn=@crossoverheuristic;         %Set crossover type  染色体交叉运算
    options.FitnessScalingFcn=@fitscalingprop;        %Set scaling type  适应度函数（系统自带）
    options.MutationFcn= @mutationadaptfeasible;      %Set mutation type  变异
    options.SelectionFcn=@selectionroulette;          %Set selection type 选择优势种群
    options.UseParallel='always';                     %Set parallel computation mode  并行运算（可以多个CPU运行）
    
    % Block 5: 设置优化参数的上下届
    %-------------------------------------------------------------------------
    lb=[0.1 0.1]; %下届
    %  [C    sigma]
    ub=[1    1]; %上届
    
    % Block 7: ％优化2个变量
    %-------------------------------------------------------------------------
    % 定义目标函数
    fun=@(x)offline(train_data, train_label,validate_data,validate_label,x(1),x(2));       
    xopt= ga(fun,2,[],[],[],[],lb,ub,[],options);          %解决优化问题
    [~, TPR,FPR,C,sigma]=fun(xopt);                           %评估优化结果
end

