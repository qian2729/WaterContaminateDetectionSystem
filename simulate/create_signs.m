function [ signs ] = create_signs(step,count,len)
%   ���ɸ�˹�ֲ���������
%   
    signs = [];
    index  = 1;
    for i = 100:step+count:len
        signs(index) = randsrc(1,1,[-1,1]);
        index = index + 1;
    end
end

