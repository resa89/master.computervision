function Uebung4_2()
signal = load('signals.mat');
signal_rec = signal.rectangle;
signal_step = signal.step;
figure;
subplot(2, 2,1);
plot(signal_rec);
subplot(2, 2,2);
plot(signal_step);

tau = 2;
lpsignal = lowpass(signal_rec, tau);
subplot(2, 2,3);
plot(lpsignal)

lpsignal = lowpass(signal_step, tau);
subplot(2, 2,4);
plot(lpsignal)

end