function [ net ] = train_ann( train_data_x, train_data_y )
%   训练Ann模型，用来做预测
%   
    P=train_data_x;
    t=train_data_y;
    net=newff(minmax(P),[20,1],{'tansig','purelin'},'trainlm');%traingdm,traingdm,traingdx,trainrp
    net=init(net);
    net.trainparam.epochs=1000;   %最大训练次数(前缺省为10,自trainrp后，缺省为100)
    net.trainparam.lr=0.05;     %学习率(缺省为0.01)
    net.trainparam.show=50;     %限时训练迭代过程(NaN表示不显示，缺省为25)
    net.trainparam.goal=0; %训练要求精度(缺省为0)
    net.trainparam.max_fail = 6;
    net.trainparam.min_grad = 1e-10;
    net.trainparam.mu = 0.001;
    net.trainparam.mu_dec = 0.1;
    net.trainparam.mu_inc = 10;
    net.trainparam.mu_max = 10000000000;
    net.performparam.regularization = 0;
    net.performparam.normalization = 'none';
    net.performFcn = 'mse';
    net.initFcn = 'initlay';
    net.divideMode = 'sample';
    net.adaptFcn = 'adaptwb';
    net.derivFcn = 'defaultderiv';
    net.divideFcn = 'dividerand';

    net=train(net,P,t);     %网络训练
end

