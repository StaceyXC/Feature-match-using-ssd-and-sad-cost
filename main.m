clc;clear;close all;

img1=imread('1.jpg');
gray1 = rgb2gray(img1);
corners1=detectHarrisFeatures(gray1);
corners1=corners1.selectStrongest(50);
img2=imread('2.jpg');
gray2 = rgb2gray(img2);
corners2=detectHarrisFeatures(gray2);
corners2=corners2.selectStrongest(50);

o1=int16(corners1.Location);
o2=int16(corners2.Location);
temp=o1(:,1);
o1(:,1)=o1(:,2);
o1(:,2)=temp;
temp=o2(:,1);
o2(:,1)=o2(:,2);
o2(:,2)=temp; %原本坐标不是yx,需要变为yx

[count,matched]=match(gray1,gray2,o1,o2);

m=max(size(img1,1),size(img2,1));n=max(size(img1,2),size(img2,2));
o2(:,2)=o2(:,2)+n;


final=zeros(m,2*n,3);
for i=1:size(img1,1)
    for j=1:size(img1,2)
        final(i,j,:)=img1(i,j,:);
    end
end
for i=1:size(img2,1)
    for j=n+1:n+size(img2,2)
        final(i,j,:)=img2(i,j-n,:);
    end
end

figure,imshow(uint8(final));
hold on;
plot(o1(:,2),o1(:,1),'ro');
plot(o2(:,2),o2(:,1),'g+');%画点
hold off;

figure,imshow(uint8(final));
hold on;
for i=1:count
     plot(o1(matched(i,1),2),o1(matched(i,1),1),'ro');
     plot(o2(matched(i,2),2),o2(matched(i,2),1),'g+');
     plot([o1(matched(i,1),2),o2(matched(i,2),2)],[o1(matched(i,1),1),o2(matched(i,2),1)],'y');
end
hold off;

figure
imshow(img1); hold on;
plot(corners1.selectStrongest(50)); %展示结果

