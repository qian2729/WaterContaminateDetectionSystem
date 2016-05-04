function [ new_dataset ] = filter_dataset( dataset )
%   �����ݽ��й��ˣ�ȥ��-3sigma ~ 3sigma �� mean֮�������
%   
    [~,col] = size(dataset);
    new_dataset = dataset;
    for i = 1:col
        vector = new_dataset(:,i);
        m = mean(vector);
        sig = std(vector);
        low = -2 * sig + m;
        high = 2 * sig + m;
        index = vector <= high & vector >= low;
        new_dataset = new_dataset(index,:);
    end
end

