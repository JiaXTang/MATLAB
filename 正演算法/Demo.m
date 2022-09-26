%%    shortest ray path  method --2D simple modle    %%
clear,clc %��������ռ估��ʾ��Ļ��
format long
Length=20;Width=8;%��ֵģ��̽������Length=20m���� Width=8m
m=17;n=21; %������ɢ��m��n�С�
%������������������ٶ�ģ��VDOTMN��
VDOTMN=ones(m,n);VDOTMN([4:5],[8:10])=4;
VDOTMN([13:14],[8:10])=4;VDOTMN([8:10],[13:15])=4;%�ڴ˹���ͼ2���ٶȳ�ģ�͡�


src_x = 1.0;  src_z = 1.0;         % Shot
rec_x = 12.0;  rec_z = 21.0;        % Recieve


[DOTMN] = FW(Length,Width,m,n,src_x,src_z,VDOTMN,rec_x,rec_z);

%% plot the result
rec_x=17;rec_z=21;

ray_x=DOTMN(rec_x,rec_z).lujing_I;
ray_z=DOTMN(rec_x,rec_z).lujing_J';

subplot() 
plot(rec_x,rec_z,'rv',m,n);hold on
plot(ray_x,ray_z,m,n);     hold on
plot(src_x,src_z,'r*');hold on

contour(VDOTMN');
grid