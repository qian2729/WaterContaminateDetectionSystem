function [ data,label ] = split_to_data_and_label( data )
%   split data to data and label
%   3~8 column is the sensor data column, 2 column is label column
    label = data(:,2);
    data = data(:,3:8);
end

