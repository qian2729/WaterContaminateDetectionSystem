function [  ] = evaluation( true_label, predict_label )
%   ��Ԥ�������п��ӻ�
%   
    figure
    subplot(211)
    bar(true_label);
    title('��ʵ�¼�');
    subplot(212)
    bar(predict_label);
    title('Ԥ���¼�');
end

