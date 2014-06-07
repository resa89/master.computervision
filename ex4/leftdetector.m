function result = leftdetector(signal1, signal2, tau)
    lpsignal = lowpass(signal2,tau);
    corr = lpsignal.*signal1;
    corr_sum = sum(corr(:));
    result = corr_sum;
return