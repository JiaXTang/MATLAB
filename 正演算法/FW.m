function [DOTMN]=FW(Length,Width,m,n,dotfa_i,dotfa_j,VDOTMN,rec_x,rec_z)
%��һ������ʼ��ʵ�ʽ�����ɢ����ʽ���ٶȳ��ֲ�����������Դ�㡣
%������������̽������x�᷽�򳤶�Length��z�᷽����Width��
%clear;clc;
%Length=20;Width=8;
%m=17;n=21; %������ɢ��m��n�С�
%������������������ٶ�ģ��VDOTMN��
%VDOTMN=ones(m,n);VDOTMN([4:5],[8:10])=4;
%VDOTMN([13:14],[8:10])=4;VDOTMN([8:10],[13:15])=4;%�ڴ˹���ͼ2���ٶȳ�ģ�͡�
%����QΪδ�����Ӳ�Դ��ļ��ϣ�P�����Ӳ�Դ��ļ��ϣ�AΪ�Ѿ��������ʱ�Ľ��
Q=zeros(m,n);P=zeros(m,n);A=zeros(m,n);S=zeros(m,n);
%������DOTMN��ʼ����
for i=1:m
    for j=1:n
          DOTMN(i,j).velocity=VDOTMN(i,j);
          DOTMN(i,j).x=(j-1)*Length/(n-1);
          DOTMN(i,j).z=(i-1)*Width/(m-1);
          DOTMN(i,j).flag_A=0;
          DOTMN(i,j).flag_Q=1;
          DOTMN(i,j).before_i=NaN;
          DOTMN(i,j).before_j=NaN;
          DOTMN(i,j).time=inf;
          DOTMN(i,j).uptime=NaN;
    end
end
%��������������Դ���ֵ
%dotfa_i=1;dotfa_j=1;
        DOTMN(dotfa_i,dotfa_j).flag_A=1;
        DOTMN(dotfa_i,dotfa_j).flag_Q=0;
        DOTMN(dotfa_i,dotfa_j).time=0;
jiedian_i=dotfa_i;
jiedian_j=dotfa_j;
for i=1:m
    for j=1:n
        if DOTMN(i,j).flag_Q==0
           P(i,j)=1;
        end
    end
end
%���㼯��P�Ľ�����\��һ����ʼ��������
counter_P=nnz(P);
%�ڶ���:��Q��һ������ʱ��С�Ľ�㡣
%���߲����жϲ��ֿ�ʼ��
while counter_P<(m*n)
%��������ȷ�����Ӳ�Դ�����ڵĽ�����������н�㼯��V�����ú���Vnew_jishuan()
[V_i,V_j]=Vnew_jishuan(jiedian_i,jiedian_j,m,n );
% return
for ii=1:length(V_i)
    i=V_i(ii);
    j=V_j(ii);
    DOTMN(i,j).flag_A=1;
end
ii=[];
for i=1:m
    for j=1:n
        if DOTMN(i,j).flag_A==1
           A(i,j)=1;
        end
    end
end
%���Ĳ�������S=(A-P) ��㵽����Դ���Ӳ�Դ����ʱ��
S=A-P;
[S_i,S_j]=find(S);
for ii=1:length(S_i)
     i=S_i(ii);
     j=S_j(ii);
     fanshu=(DOTMN(i,j).x-DOTMN(jiedian_i,jiedian_j).x).^2+(DOTMN(i,j).z-DOTMN(jiedian_i,jiedian_j).z).^2;
     DOTMN(i,j).uptime=2*sqrt(fanshu)/(DOTMN(i,j).velocity+DOTMN(jiedian_i,jiedian_j).velocity);
%���岽����S���ϸ�����������ʱ
     tmin_panju=min(DOTMN(i,j).time,DOTMN(jiedian_i,jiedian_j).time+DOTMN(i,j).uptime);
     if tmin_panju<DOTMN(i,j).time
        DOTMN(i,j).time=tmin_panju;
        DOTMN(i,j).before_i=jiedian_i;
        DOTMN(i,j).before_j=jiedian_j;
     end
end
%�ڶ�������Q��һ������ʱ��С�Ľ�㡣
time_min=inf;
for ii=1:length(S_i)
     i=S_i(ii);
     j=S_j(ii);
     DotTime(i,j)=DOTMN(i,j).time;
     if DotTime(i,j)<=time_min
        time_min=DotTime(i,j);
        jiedian_i=i;
        jiedian_j=j;
     end
end
%�����������Ӳ�����ƶ�������Q������P���Ͻ��ĸ�����
DOTMN(jiedian_i,jiedian_j).flag_Q=0;
for i=1:m
    for j=1:n
        if DOTMN(i,j).flag_Q==0
           P(i,j)=1;
        end
    end
end
counter_P=nnz(P);
%     if (counter_P == 112) 
%         disp(counter_P)
%         return
%     end;
end


%���߲����жϽ���������
%�ڰ˲������Ƴ�����·��DOTMN().lujing_I��,DOTMN().lujing_J
%Ԥ�����յ�ѭ����
tic;
for dotjie_i=1:m
 
    for dotjie_j=1:n
        lu_i=dotjie_i;
        lu_j=dotjie_j;
        Xi(1)=lu_i;
        Zj(1)=lu_j;
        counter_lu=2;
        lu_panju=isnan(DOTMN(lu_i,lu_j).before_i);
        while lu_panju<1
              Xi(counter_lu)=DOTMN(lu_i,lu_j).before_i;
              Zj(counter_lu)=DOTMN(lu_i,lu_j).before_j;
              lu_temp=lu_i;
              lu_i=DOTMN(lu_i,lu_j).before_i;
              lu_j=DOTMN(lu_temp,lu_j).before_j;
              lu_temp=[];
              lu_panju=isnan(DOTMN(lu_i,lu_j).before_i);   %һֱ�ҵ���Դ��Ϊֹ
              counter_lu=counter_lu+1;
        end
        DOTMN(dotjie_i,dotjie_j).lujing_I=Xi;
        DOTMN(dotjie_i,dotjie_j).lujing_J=Zj;
        Xi=[];Zj=[];
    end
 
end
disp('!===== Ray Trace End =====!')
toc;
%�ڰ˲�������

