function X = SIRT(A,T,e,maxit)
%SIRT算法
%输出：重建图像X
%输入：
%A:系统矩阵（路径矩阵）
%N:图像大小
%T:投影矩阵（走时）
%Niter：迭代次数
%e:代表松弛因子，这里取e = 0.5

%irt_num:停止条件
[N,M] = size(A);%获取矩阵大小
Xold=zeros(N*N,1);%初始慢速矩阵
X=sum(A');
for ind = 1 : maxit
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
        X(j,1)=Xold(j,1)+e*s3;%对每一个投影点进行修正
    end
    Xold=X;
end
 