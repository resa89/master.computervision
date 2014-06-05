function result = detector(signal1, signal2, tau)
    lpsignal = lowpass(signal1,tau);
    corr = lpsignal.*signal2;
    corr_sum = sum(corr(:));
    result = corr_sum;
return