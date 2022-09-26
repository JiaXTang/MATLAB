clc
clear
close all
%载入系统矩阵
load 11.mat  %载入系统矩阵
%载入系统矩阵
load wuzhangaiwu.mat  %载入走时
T=resDelay;
maxT=max(T);
minT=min(T);
a=0;
b=10;
for i=1:length(T)
T(i)=a + (b - a) * (T(i) - minT)/(maxT - minT)
end

%同量纲
% LSQR反演重建
maxit=30000;
X=lsqr(A,T',[],maxit);%调用LSQR函数
for i=1:length(X)
X(i)=a + (b - a) * (X(i) - minT)/(maxT - minT)
end
X=reshape(X,30,30);
% 显示结果
subplot(1, 2, 1), imshow(X), title('LSQR')




