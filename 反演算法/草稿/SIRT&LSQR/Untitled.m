clc
clear
close all

gridsize=0.05;%网格大小

%设置慢度模型
V=15*ones(100,100);
[r, c] = size(V);%r是V的行数（即纵坐标），c是V的列数
V(floor(3/10*r-2*gridsize:7/10*r+2*gridsize), floor(3/10*c-2*gridsize:7/10*c+gridsize+2*gridsize)) = 3;%设置速度模型 -gridsize
V(floor(3/10*r:7/10*r), floor(3/10*c:7/10*c)) = 1;%设置速度模型
P=1./V;
subplot(1, 2, 1), imshow(P), title('Original')
% figure(1);pcolor(P);caxis([1/3500,1/1000]);colorbar;%imshow(P,'InitialMagnification','')
% title('设置的慢度P');


%载入系统矩阵
load matlab.mat  %载入系统矩阵
A=A';            %旋转系统矩阵

%获取投影值

P=reshape(P,100*100,1);
T=A*P;

% LSQR反演重建
maxit=30000;
X=lsqr(A,T,[],maxit);%调用LSQR函数
X=reshape(X,100,100);

% 显示结果
subplot(1, 2, 2), imshow(X), title('LSQR')




