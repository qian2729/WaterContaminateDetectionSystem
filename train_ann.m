function [ net ] = train_ann( train_data_x, train_data_y )
%   ѵ��Annģ�ͣ�������Ԥ��
%   
    P=train_data_x;
    t=train_data_y;
    net=newff(minmax(P),[30,1],{'tansig','purelin'},'trainlm');%traingdm,traingdm,traingdx,trainrp
    net=init(net);
    net.trainparam.epochs=300;   %���ѵ������(ǰȱʡΪ10,��trainrp��ȱʡΪ100)
    net.trainparam.lr=0.01;     %ѧϰ��(ȱʡΪ0.01)
    net.trainparam.show=50;     %��ʱѵ����������(NaN��ʾ����ʾ��ȱʡΪ25)
    net.trainparam.goal=1e-8; %ѵ��Ҫ�󾫶�(ȱʡΪ0)
    net.performFcn = 'mse';
    net.initFcn = 'initlay';
    net.divideMode = 'sample';
    net.adaptFcn = 'adaptwb';
    net.derivFcn = 'defaultderiv';
    net.divideFcn = 'dividerand';

    net=train(net,P,t);     %����ѵ��
end

