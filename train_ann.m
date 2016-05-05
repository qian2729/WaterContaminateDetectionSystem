function [ net ] = train_ann( train_data_x, train_data_y )
%   ѵ��Annģ�ͣ�������Ԥ��
%   
    P=train_data_x;
    t=train_data_y;
    net=newff(minmax(P),[20,1],{'tansig','purelin'},'trainlm');%traingdm,traingdm,traingdx,trainrp
    net=init(net);
    net.trainParam.epochs=1000;   %���ѵ������(ǰȱʡΪ10,��trainrp��ȱʡΪ100)
    net.trainParam.lr=0.01;     %ѧϰ��(ȱʡΪ0.01)
    net.trainParam.show=50;     %��ʱѵ����������(NaN��ʾ����ʾ��ȱʡΪ25)
    net.trainParam.goal=0;      %ѵ��Ҫ�󾫶�(ȱʡΪ0)
    net.trainParam.max_fail = 6;
    net.trainParam.min_grad = 1e-10;
    net.trainParam.mu = 0.001;
    net.trainParam.mu_dec = 0.1;
    net.trainParam.mu_inc = 10;
    net.performFcn = 'mse';
    net.initFcn = 'initlay';
    net.divideMode = 'sample';
    net.adaptFcn = 'adaptwb';
    net.derivFcn = 'defaultderiv';
    net.divideFcn = 'dividerand';
    net.biasConnect = [1; 1];
    net.inputConnect = [1; 0];
    net.layerConnect = [0 0; 1 0];
    net.outputConnect = [0 1];
    net=train(net,P,t);     %����ѵ��
end

