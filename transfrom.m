function outputPic = transfrom(A, gray, a0, neighbor)
    [m,n] = size(gray);
    newM = zeros(m*3, n*3);
    
    for i=1:m*3
        for j=1:n*3
            tmp = [i-m j-n 0] * A + a0;
            yx0=floor(tmp);
            yx1=ceil(tmp);

            if yx1(1) <= m && yx0(1) > 0 && yx1(2) <=n && yx0(2) > 0
                wt = tmp - yx0; 
                wtConj = 1 - wt;

                if neighbor
                    % use the value of the next neighbor
                    if wt(1) >= 0.5
                        y=yx1(1);
                    else
                        y=yx0(1);
                    end
                    if wt(2) >= 0.5
                        x = yx1(2);
                    else 
                        x=yx0(2);
                    end
                    interVal = gray(y,x);
                else
                    % biliniar interpolation
                    interTop = wtConj(2) * gray(yx0(1),yx0(2)) + wt(2) * gray(yx0(1),yx1(2));
                    interBtm = wtConj(2) * gray(yx1(1),yx0(2)) + wt(2) * gray(yx1(1),yx1(2));
                    interVal=wtConj(1) * interTop + wt(1) * interBtm;
                end
                newM(i, j) = interVal;
            end
        end
    end
    outputPic = newM;
end

