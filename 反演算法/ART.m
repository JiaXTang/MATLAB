function X=ART(A,T,e,maxit)
% 该程序为ART反演算法，返回计算得到的慢度矩阵
%A 路径矩阵
%T 走时矩阵
%x 初始慢度矩阵
%Niter表示迭代次数;
%I、br分别代表射线观测走时向量和计算射线走时向量;
%e代表松弛因子，这里取e=0.5。

[N,M]=size(A);%获取矩阵大小.
X=zeros(N*N,1);%初始慢速矩阵
b=T';
Norm=diag(A*A');
for ii=1:maxit  %循环体开始
    ii
    for jj=1:N
        Q=(X*A(jj,:)');%迭代过程
        Delta=(b(jj)-Q)./Norm(jj)*A(jj,:);
        X=X+e*Delta; %e--relaxationfaetor
    end
    X= X.*(1+sign(X))/2.*abs(sign(X));
end%循环体结束
X=X';%返回慢度向量
