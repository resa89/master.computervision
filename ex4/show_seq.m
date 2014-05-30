function show_seq(seq)
    [t,y,x] = size(seq);
    
    for num=1:t
        img = seq(num,:,:);
        img = squeeze(img);
%         imshow(img);
        show_img(img, [0 1], 'auto', 'image sequence', 256);
        waitforbuttonpress;
    end
end