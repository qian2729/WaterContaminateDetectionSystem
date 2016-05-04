
% paper 中的数据
% raw_data = load('data_without_events.txt');
% event_data = load('data_with_low_events.txt');
% 我们的数据
raw_data = load('new_data.csv');
event_data = load('new_data_with_event.csv');
figure
for i = 1:6
   subplot(3,2,i);
   a = (raw_data(:,i + 2) - event_data(:,i+2));
   plot(a);
end





