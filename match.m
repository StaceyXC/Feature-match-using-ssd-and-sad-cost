function [count,matched]=match(img1,img2,corners1,corners2)
img1=im2double(img1);img2=im2double(img2);
if size(img1,3)==3
    img1_gray=rgb2gray(img1);
else
    img1_gray=img1;
end

if size(img2,3)==3
    img2_gray=rgb2gray(img2);
else
    img2_gray=img2;
end

c1=size(corners1,1);
c2=size(corners2,1);
[m1,n1]=size(img2_gray);
[m2,n2]=size(img2_gray);

count=1;
matched=zeros(max(c1,c2),2); %返回max*2的矩阵
for i=1:c1
    d_t=99;
    for j=1:c2 
        if corners2(j,1)>1&&corners2(j,1)<m2&&corners2(j,2)>1&&corners2(j,2)<n2&&corners1(i,1)>1&&corners1(i,1)<m1&&corners1(i,2)>1&&corners1(i,2)<n1
            d=0;
            for x=-1:1
                for y=-1:1
                    d=d+(img1_gray(corners1(i,1)+x,corners1(i,2)+y)-img2_gray(corners2(j,1)+x,corners2(j,2)+y))^2;
                end
            end
            if d<d_t&&d<0.1     % 此处设置阈值,这是多次实验设置出的阈值
                d_t=d;
                matched(count,:)=[i,j];
            end
        end
    end   %懂了，两组角点的3*3矩阵分别图像匹配。
    if matched(count,1)~=0 %不等于
        count=count+1;
    end
end
count=count-1;

end
