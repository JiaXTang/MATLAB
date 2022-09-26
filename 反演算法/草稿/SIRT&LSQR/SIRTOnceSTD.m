%SIRT�ؽ����򣬲��������½�����STD���Ե������������Ż�
clc
clear
close all
% load SystemMatrix128.mat
% N=128;

% load SystemMatrix160.mat
% N=160;
load matlab.mat  %����ϵͳ����
N=100;                    %ͼ���СN*N
A=A';                     %��תϵͳ����

P=phantom(N);             %ԭʼͼ��Shepp-Loganģ��
X0=reshape(P,N*N,1);      %����άͼ��ת��Ϊһά����
B=A*X0;                   %����ͶӰ����
X1=A'*B;                  %��һ���������ɵĳ�ʼ�ؽ�ͼ��
% lmd=0.0002;


x=zeros(N*N,1);
for ind=1:80               %80�η����ؽ�
    ind
    r=B-A*x;
    rk=A'*r;
    ra=A*rk;
    rb=A'*ra;
    lamuda=sum(rk.*rk)/sum(rb.*rk);     %�����½��������������
    x=x+lamuda*rk;
    
%     oldB=A*Xold;
%     dB=B-oldB;
%     Xnew=Xold+lmd*A'*dB;
    NegInd=find(x<0);      %������ֵ
    x(NegInd)=0;
    if mod(ind,20)==1 && ind <700
    x=reshape(x,N,N);
    x=medfilt2(x,[3,3]);
    x=reshape(x,N*N,1);
    end
%     Xold=Xnew;
end


Im1=reshape(X1,N,N);       %��һ���������ɵĳ�ʼ�ؽ�ͼ��   
figure;
imshow(P);               %��ʾԭʼͼ��
% figure;
% imshow(Im1);

figure;                   %��ʾ��ʼ�ؽ�ͼ��
imshow(Im1/max(Im1(:)));

Im2=reshape(x,N,N);
figure;
imshow(Im2);              %��ʾ��ε������ɵ��ؽ�ͼ��

figure;
imshow(Im2/max(Im2(:)));


imwrite(P,'ԭʼSP.bmp','bmp');
imwrite(Im1,'SITR1.bmp','bmp');
imwrite(Im2,'SITR500_1.bmp','bmp');

P = phantom(128);       %FBP�㷨�ؽ�Shepp-Loganģ��
R = radon(P,0:15:179);  %��ȡͶӰ����
I1 = iradon(R,0:15:179); %�ؽ�ͼ��
% I2 = iradon(R,0:12:179,'linear','none');
% subplot(1,3,1), imshow(P), title('Original')
imwrite(I1,'FBP.bmp','bmp');