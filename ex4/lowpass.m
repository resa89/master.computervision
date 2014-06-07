function lpsignal = lowpass(signal,tau)

    a = 1/tau;
    
    %dimension of signal depends on input array (vertical/horizontal)
    signalSize = size(signal,2);
        if signalSize==1
            signalSize = size(signal,1);
        end
    
    old = 0;   
    for n=1:signalSize
        signal(n)  = a * signal(n) + (1-a) * old;
        old = signal(n);
    end

    lpsignal = signal;
return 