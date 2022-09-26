%SIRT重建程序，采用最速下降法（STD）对迭代步长进行优化
clc
clear
close all
% load SystemMatrix128.mat
% N=128;

% load SystemMatrix160.mat
% N=160;
load matlab.mat  %载入系统矩阵
N=100;                    %图像大小N*N
A=A';                     %旋转系统矩阵

P=phantom(N);             %原始图像，Shepp-Logan模型
X0=reshape(P,N*N,1);      %将二维图像转换为一维向量
B=A*X0;                   %计算投影数据
X1=A'*B;                  %第一步迭代生成的初始重建图像
% lmd=0.0002;


x=zeros(N*N,1);
for ind=1:80               %80次反复重建
    ind
    r=B-A*x;
    rk=A'*r;
    ra=A*rk;
    rb=A'*ra;
    lamuda=sum(rk.*rk)/sum(rb.*rk);     %最速下降法计算迭代步长
    x=x+lamuda*rk;
    
%     oldB=A*Xold;
%     dB=B-oldB;
%     Xnew=Xold+lmd*A'*dB;
    NegInd=find(x<0);      %修正负值
    x(NegInd)=0;
    if mod(ind,20)==1 && ind <700
    x=reshape(x,N,N);
    x=medfilt2(x,[3,3]);
    x=reshape(x,N*N,1);
    end
%     Xold=Xnew;
end


Im1=reshape(X1,N,N);       %第一步迭代生成的初始重建图像   
figure;
imshow(P);               %显示原始图像
% figure;
% imshow(Im1);

figure;                   %显示初始重建图像
imshow(Im1/max(Im1(:)));

Im2=reshape(x,N,N);
figure;
imshow(Im2);              %显示多次迭代生成的重建图像

figure;
imshow(Im2/max(Im2(:)));


imwrite(P,'原始SP.bmp','bmp');
imwrite(Im1,'SITR1.bmp','bmp');
imwrite(Im2,'SITR500_1.bmp','bmp');

P = phantom(128);       %FBP算法重建Shepp-Logan模型
R = radon(P,0:15:179);  %获取投影数据
I1 = iradon(R,0:15:179); %重建图像
% I2 = iradon(R,0:12:179,'linear','none');
% subplot(1,3,1), imshow(P), title('Original')
imwrite(I1,'FBP.bmp','bmp');