%% ART based on FLA
clear all
close all
clc;

L = 256;%ͼ���С
nIter = 0;% ��������
iterOK = 0;
iter0 = ones(4*L)*0.2;%Ԫ��Ϊ0.2�ľ���
theta0 = [0:14; 15:29; 30:44; 45:59; 60:74; 75:89; 90:104; 105:119; 120:134; 135:149; 150:164; 165:179];
theta = reshape (theta0, 180, 1);%theta = [0,15,30,...165,1,16,31,...166,2,17,32,...167,......]'
nTheta = length(theta);% 180

%% ����ͶӰ���Լ���ʼ��������
I = phantom (L);% ԭʼͼ��
R1 = zeros(L,L);% ������ֵΪ0

% P1 = radon (I, 0:30:179);
% R1 = iradon (P1, 0:30:179, 'linear', 'hamming');% ������ʼֵΪR1(Ч����)

for aa = 1:L %%
    for bb = 1:L
        iter0 ((4*aa-3):4*aa, (4*bb-3):4*bb) = R1 (aa, bb)/16;
        I1 ((4*aa-3):4*aa, (4*bb-3):4*bb) = I (aa, bb)/16;% ��ԭͼ����4��
    end
end

%% ��ʼ����  ÿ����һ��ͶӰ�Ƕȸ���һ��ͼ��
while (nIter <= 10)% ��������
    nIter = nIter + 1;
    temp = mod(nIter-1, nTheta)+1;
%һ�ε�������
    for ii = 1:L
        %ȷ���������ĵ�
        proj = zeros (4*L);
        proj (:,(4*ii-3):4*ii) = 1;% (4*ii-3)~4*ii �е�ֵΪ1
        proj1 = imrotate (proj, theta (temp), 'crop');% ȷ��������
        P_proj = sum(sum(I1.*proj1));
        R_proj = sum(sum(iter0.*proj1));
        pp_proj = sum(sum(proj1 .* proj1));
        iter1 = iter0 - proj1.*(R_proj-P_proj)/pp_proj;% sum(sum(proj))
        iter0 = iter1;    
    end
%һ�ε������̽���
end
% imshow(iter0);

%% �ؽ���ͼ��
R = zeros(L);
for aa = 1:L;
    for bb = 1:L;
        R (aa, bb) = sum(sum(iter0((4*aa-3):4*aa,(4*bb-3):4*bb)));
    end
end

subplot(1, 2, 2), imshow(R), title('ART')
 subplot(1, 2, 1), imshow(I), title('Original')
