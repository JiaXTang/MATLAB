clc
clear
close all
% load SystemMatrix128.mat
% N=128;

% load SystemMatrix160.mat
% N=160;
load A.mat  %载入系统矩阵
N=250;                    %图像大小N*N
A=A';                     %旋转系统矩阵

P=phantom(N);            %原始图像，Shepp-Logan模型


X0=reshape(P,N*N,1);     %将二维图像转换为一维向量
B=A*X0;                  %计算投影数据

X1=A'*B;                 %第一步迭代生成的初始重建图像
B1=A*X1;                 %初始重建图像对应的投影数据



lmd=0.0002;              %固定的迭代步长


%% LSQR
 maxit=30000;
 X=lsqr(A,B,[],maxit);%调用LSQR函数
 X=reshape(X,N,N);
%% sirt
T=B;
lmd=0.02;              %固定的迭代步长
Xold=zeros(N*N,1);
for ind=1:800          %800次反复重建
    ind
    oldB=A*Xold;%计算投影值                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    dB=T-oldB;%投影修正值
    Xnew=Xold+lmd*A'*dB;
    Xnew(Xnew > 1) = 1; Xnew(Xnew < 0) = 0;
    Xold=Xnew;    
end

%% SIRT
T=B;
lambda=1;%松弛因子
Xold=zeros(N*N,1);
X=sum(A);
ii=1;
for ind = 1 : 10
        ind
    oldT=A*Xold;%计算估算投影值                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    dT=T-oldT;%投影修正值
    [m,n]=size(A);
    for j = 1 : n
        s2=0;s1=eps;
        for i = 1 : m
            s2=s2+A(i,j)*dT(i)/(X(i)+eps);
            s1=s1+A(i,j);
        end
        s3=s2/(s1+eps);
        Xnew(j,1)=Xold(j,1)+lambda*s3;%对每一个投影点进行修正
    end
    Xold=Xnew;
end
Xnew=reshape(Xold,N,N);

%% 显示结果
subplot(1, 2, 2), imshow(X), title('LSQR')
subplot(1, 2, 1), imshow(P), title('Original')
subplot(2, 2, 3), imshow(Xnew), title('SIRT')


