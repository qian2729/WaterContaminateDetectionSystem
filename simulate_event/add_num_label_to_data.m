% ��ԭʼ������������У���һ��Ϊ��ţ��ڶ���Ϊ���
new_data = load('../new_data.csv');
[n,m] = size(new_data);
labels = zeros(n,1);
nums = 1:n;
nums = nums';
new_data = [nums labels new_data];
dlmwrite('../new_data.csv',new_data, ',');
