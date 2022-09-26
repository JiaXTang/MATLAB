clc
clear
close all

gridsize=0.05;%�����С

%��������ģ��
V=15*ones(100,100);
[r, c] = size(V);%r��V���������������꣩��c��V������
V(floor(3/10*r-2*gridsize:7/10*r+2*gridsize), floor(3/10*c-2*gridsize:7/10*c+gridsize+2*gridsize)) = 3;%�����ٶ�ģ�� -gridsize
V(floor(3/10*r:7/10*r), floor(3/10*c:7/10*c)) = 1;%�����ٶ�ģ��
P=1./V;
subplot(1, 2, 1), imshow(P), title('Original')
% figure(1);pcolor(P);caxis([1/3500,1/1000]);colorbar;%imshow(P,'InitialMagnification','')
% title('���õ�����P');


%����ϵͳ����
load matlab.mat  %����ϵͳ����
A=A';            %��תϵͳ����

%��ȡͶӰֵ

P=reshape(P,100*100,1);
T=A*P;

% LSQR�����ؽ�
maxit=30000;
X=lsqr(A,T,[],maxit);%����LSQR����
X=reshape(X,100,100);

% ��ʾ���
subplot(1, 2, 2), imshow(X), title('LSQR')




