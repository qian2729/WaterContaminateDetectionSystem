% old = load('data_with_low_events.txt');
% old_label = old(:,2);
% figure(5)
% % bar(old_label,'b')
% % hold on;
% new = load('new_data_with_event.csv');
% new_label = new(:,2);
% bar(new_label,'b')
% % hold off;

a = 3;
b = 9;
plot(raw_data(:,a) - event_data(:,a));
hold on;
plot(raw_data(:,b) - event_data(:,b));
hold off;