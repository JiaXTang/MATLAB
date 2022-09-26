clc
clear
close all
%����ϵͳ����
load 11.mat  %����ϵͳ����
%����ϵͳ����
load wuzhangaiwu.mat  %������ʱ
T=resDelay;
maxT=max(T);
minT=min(T);
a=0;
b=10;
for i=1:length(T)
T(i)=a + (b - a) * (T(i) - minT)/(maxT - minT)
end

%ͬ����
% LSQR�����ؽ�
maxit=30000;
X=lsqr(A,T',[],maxit);%����LSQR����
for i=1:length(X)
X(i)=a + (b - a) * (X(i) - minT)/(maxT - minT)
end
X=reshape(X,30,30);
% ��ʾ���
subplot(1, 2, 1), imshow(X), title('LSQR')




