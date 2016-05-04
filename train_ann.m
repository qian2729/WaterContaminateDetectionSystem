function [ net ] = train_ann( train_data_x, train_data_y )
%   训练Ann模型，用来做预测
%   
    P=train_data_x;
    t=train_data_y;
    net=newff(minmax(P),[30,1],{'tansig','purelin'},'trainlm');%traingdm,traingdm,traingdx,trainrp
    net=init(net);
    net.trainparam.epochs=300;   %最大训练次数(前缺省为10,自trainrp后，缺省为100)
    net.trainparam.lr=0.01;     %学习率(缺省为0.01)
    net.trainparam.show=50;     %限时训练迭代过程(NaN表示不显示，缺省为25)
    net.trainparam.goal=1e-8; %训练要求精度(缺省为0)
    net.performFcn = 'mse';
    net.initFcn = 'initlay';
    net.divideMode = 'sample';
    net.adaptFcn = 'adaptwb';
    net.derivFcn = 'defaultderiv';
    net.divideFcn = 'dividerand';

    net=train(net,P,t);     %网络训练
end

