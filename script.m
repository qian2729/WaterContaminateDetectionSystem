% no_event = load('data_without_events.txt');
% event = load('data_with_low_events.txt');


for i = 1:6
   subplot(3,2,i);
   a = (raw_data(:,i) - event_data(:,i));
   
%    fprintf('sigma:%.5f<-%.5f\n',var(a(1250:1350)),var(no_event(:,i + 2)));
   plot(a);
end





