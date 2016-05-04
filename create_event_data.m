addpath('simulate_event/');

new_data = load('new_data.csv');
[ event_data ] = add_event_to_data(new_data);
dlmwrite('new_data_with_event.csv', event_data, ',');