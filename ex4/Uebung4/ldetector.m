function result = ldetector(signal1, signal2, tau)
size(signal1);

lpsignal = lowpass(signal2,tau);

% figure;
% subplot(2, 2,3);
% plot(lpsignal)
% 
% subplot(2, 2,1);
% plot(signal2)

size(lpsignal);
size(signal2);

corr = lpsignal.*signal1;
%plot(corr)
corr_sum = sum(corr(:));
%corr = corrcoef(lpsignal,signal2);
%covv = cov(lpsignal,signal2)
result = corr_sum;
return