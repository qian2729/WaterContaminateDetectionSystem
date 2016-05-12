function [ X_data, Y_data, labels ] = convert_data_to_ann_input( data )
%   Convert data to ann input format. 
%   
%
%   [ ann_inputs ] = convert_data_to_ann_input( data )
%   data:
%       dimension of data: n * 9, the 1 dimension is order number
%       the 2 dimension is the label, the 3~8 dimension is sensor data
%   X_data:
%       X_data is a cell array, each cell contains one kind of sensor
%       data for ann input
%   Y_data:
%       Y_data is a cell array, each cell contains one kind of sensor data
%       for ann output
    
    labels = data(2:end,2);
    X_data = cell(1,6);
    Y_data = cell(1,6);
    for i = 1:6
       idx = i + 2; % sensor data index
       Y_data{i} = data(2:end,idx);
       X_data{i} = [data(2:end,[3:idx - 1 idx+1:end]) data(1:end-1,idx)];
    end
end

