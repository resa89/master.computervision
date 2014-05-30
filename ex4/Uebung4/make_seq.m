function sinus_seq = make_seq(dimt, dimy, dimx, v)

lambda = 0.5*dimx;
mean_brightness = 0;
%contrast = (Imax - Imin) / (Imax + Imin);
%1 - 0 / 1 + 0 = 1
out = zeros(dimt,dimy,dimx);

for i=1:dimt
    for x=1:dimx
       out(i,:,x) =  0.5 *  sin(((2*pi/lambda)*x) - ((i-1)*v)) + 0.5;
    end
end


sinus_seq.seq = out;

return 


