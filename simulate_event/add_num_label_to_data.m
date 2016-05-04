% 在原始数据中添加两列，第一列为序号，第二列为类标
new_data = load('../new_data.csv');
[n,m] = size(new_data);
labels = zeros(n,1);
nums = 1:n;
nums = nums';
new_data = [nums labels new_data];
dlmwrite('../new_data.csv',new_data, ',');
