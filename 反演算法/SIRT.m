function X = SIRT(A,T,e,maxit)
%SIRT�㷨
%������ؽ�ͼ��X
%���룺
%A:ϵͳ����·������
%N:ͼ���С
%T:ͶӰ������ʱ��
%Niter����������
%e:�����ɳ����ӣ�����ȡe = 0.5

%irt_num:ֹͣ����
[N,M] = size(A);%��ȡ�����С
Xold=zeros(N*N,1);%��ʼ���پ���
X=sum(A');
for ind = 1 : maxit
        ind
    oldT=A*Xold;%�������ͶӰֵ                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    dT=T-oldT;%ͶӰ����ֵ
    [m,n]=size(A);
    for j = 1 : n
        s2=0;s1=eps;
        for i = 1 : m
            s2=s2+A(i,j)*dT(i)/(X(i)+eps);
            s1=s1+A(i,j);
        end
        s3=s2/(s1+eps);
        X(j,1)=Xold(j,1)+e*s3;%��ÿһ��ͶӰ���������
    end
    Xold=X;
end
 