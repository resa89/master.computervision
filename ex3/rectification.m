function outputPic = rectification(x, xp, y, yp, img)
    M = [];
    s = size(x);
    for i=1:s(2)
        tmp = [xp(i) yp(i) 1 0     0     0 -x(i)*xp(i) -x(i)*yp(i);
               0     0     0 xp(i) yp(i) 1 -y(i)*xp(i) -y(i)*yp(i)];
        M = [M; tmp];
    end

    xv = [x(1); y(1); x(2); y(2); x(3); y(3); x(4); y(4)];

    a = pinv(M) * xv;
    a1 = a(1);
    a2 = a(2);
    a3 = a(3);
    b1 = a(4);
    b2 = a(5);
    b3 = a(6);
    c1 = a(7);
    c2 = a(8);

    [m,n,o] = size(img);
    newM = zeros(m, n, o);

    minX = n;
    for y=1:m
        for x=1:n
            denominator = (b1*c2 - b2*c1)*x + (a2*c1 - a1*c2)*y + a1*b2 - a2*b1;
            xCorrected = ((b2-c2*b3)*x + (a3*c2-a2)*y + a2*b3-a3*b2) / denominator;
            yCorrected = ((b3*c1-b1)*x + (a1-a3*c1)*y + a3*b1-a1*b3) / denominator;
            xCorrected = floor(xCorrected);
            yCorrected = floor(yCorrected);
            if yCorrected > 0 && yCorrected <= m && xCorrected > 0 && xCorrected <= n
                newM(y, x,:) = img(yCorrected, xCorrected, :);
%                 if x > maxX 
%                     maxX = x;
%                 end
            end
            
            if xCorrected >= n
                if x < minX
                    minX = x - 1;
                end
                break;
            end
        end
        if yCorrected >= m
            newM = newM(1:y-1, 1:minX, :);
%             outputPic = newM;
            break;
        end
    end
    outputPic = newM;
end