% ����������������쳣���ݵĽű�

new_data = load('../data/new_data.csv');
[ event_data ] = add_event_to_data(new_data);
dlmwrite('../data/new_data_with_event.csv', event_data, ',');