function [ train_data, test_data ] = split_data_to_train_test(data)
% Convert data to train data and test data( 2/3 for train, 1/3 for test).
%
% [train_data, test_data] = split_data_to_train_test(data)
%   data: data matrix, dimension is n * m, n is size of samples and
%         m is kinds of sensor data
%   train_data: 2/3 rows of data 
%   test_data:  1/3 rows of data
%
%
%  NOTE: in data, row for sample and column for sensor:
    FOLDS = 3;  % split data to FOLDS part
    test_size = floor(size(data,1) / FOLDS);
    test_data = data(test_size + 1:test_size + test_size,:);
    train_data = data([1:test_size,test_size * 2 + 1:end],:);
end

