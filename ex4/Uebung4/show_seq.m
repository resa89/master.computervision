function show_seq(seq)

%Extract frames
local_seq = seq.seq;
size(local_seq)
frames = size(local_seq,1)

%Set figure dimensions
figure;
fig_height = ceil(frames / 5); 
fig_width =  ceil(frames / fig_height);

for i=1:frames














subplot(fig_height, fig_width,i);
pic1(:,:) = local_seq(i,:,:);
imshow(pic1);
waitforbuttonpress
end






end 