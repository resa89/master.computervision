function M_out = make_seq(dimt, dimy, dimx, v)
    % dimt 
    
    % wavelength lamda = 0.5 * dimx 
    % sin(0)=0 sin(90)=1, sin(180)=0 sin(270)=-1 sin(360)=0 ...
    % => dimx ~ 360°
    
    % dimy height of the sinus => dimy * sin()
    
    % v pixel per timeslot
    
    M = zeros(dimt, dimx, dimx);  %evtl. noch dimt
    %M_out = zeros(dimt, dimx, dimx);  %evtl. noch dimt
    
    xScale = 4 * pi / dimx;
    for t=1:dimt
        offset = t * v;
        for x=0:dimx
            fx = sin(xScale * (x + offset)); % fx [-1 1];
%             y = fx * dimy;
            M(t, :, x+1) = fx;
        end
%         show_img(M(t, :, :), [-dimy dimy], 'auto', 'image sequence', 256);
%         waitforbuttonpress;
    end
    
    M_out = M;
end

