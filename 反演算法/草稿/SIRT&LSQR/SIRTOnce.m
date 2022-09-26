clc
clear
close all
% load SystemMatrix128.mat
% N=128;

% load SystemMatrix160.mat
% N=160;
load A.mat  %����ϵͳ����
N=250;                    %ͼ���СN*N
A=A';                     %��תϵͳ����

P=phantom(N);            %ԭʼͼ��Shepp-Loganģ��


X0=reshape(P,N*N,1);     %����άͼ��ת��Ϊһά����
B=A*X0;                  %����ͶӰ����

X1=A'*B;                 %��һ���������ɵĳ�ʼ�ؽ�ͼ��
B1=A*X1;                 %��ʼ�ؽ�ͼ���Ӧ��ͶӰ����



lmd=0.0002;              %�̶��ĵ�������


%% LSQR
 maxit=30000;
 X=lsqr(A,B,[],maxit);%����LSQR����
 X=reshape(X,N,N);
%% sirt
T=B;
lmd=0.02;              %�̶��ĵ�������
Xold=zeros(N*N,1);
for ind=1:800          %800�η����ؽ�
    ind
    oldB=A*Xold;%����ͶӰֵ                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    dB=T-oldB;%ͶӰ����ֵ
    Xnew=Xold+lmd*A'*dB;
    Xnew(Xnew > 1) = 1; Xnew(Xnew < 0) = 0;
    Xold=Xnew;    
end

%% SIRT
T=B;
lambda=1;%�ɳ�����
Xold=zeros(N*N,1);
X=sum(A);
ii=1;
for ind = 1 : 10
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
        Xnew(j,1)=Xold(j,1)+lambda*s3;%��ÿһ��ͶӰ���������
    end
    Xold=Xnew;
end
Xnew=reshape(Xold,N,N);

%% ��ʾ���
subplot(1, 2, 2), imshow(X), title('LSQR')
subplot(1, 2, 1), imshow(P), title('Original')
subplot(2, 2, 3), imshow(Xnew), title('SIRT')


