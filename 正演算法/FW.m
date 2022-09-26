function [DOTMN]=FW(Length,Width,m,n,dotfa_i,dotfa_j,VDOTMN,rec_x,rec_z)
%第一步：初始化实际介质离散化方式及速度场分布，并设置震源点。
%输入以下输入探测区域x轴方向长度Length，z轴方向宽度Width。
%clear;clc;
%Length=20;Width=8;
%m=17;n=21; %区域离散化m行n列。
%输入以下输入结点矩阵速度模型VDOTMN：
%VDOTMN=ones(m,n);VDOTMN([4:5],[8:10])=4;
%VDOTMN([13:14],[8:10])=4;VDOTMN([8:10],[13:15])=4;%在此构造图2的速度场模型。
%定义Q为未作过子波源点的集合；P作过子波源点的集合；A为已经计算过走时的结合
Q=zeros(m,n);P=zeros(m,n);A=zeros(m,n);S=zeros(m,n);
%结点矩阵DOTMN初始化。
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
%输入以下输入震源点初值
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
%计算集合P的结点个数\第一步初始化结束。
counter_P=nnz(P);
%第二步:找Q中一个旅行时最小的结点。
%第七部分判断部分开始。
while counter_P<(m*n)
%第三步：确定与子波源点所在的结点相连的所有结点集合V，调用函数Vnew_jishuan()
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
%第四步：计算S=(A-P) 结点到子震源的子波源的走时。
S=A-P;
[S_i,S_j]=find(S);
for ii=1:length(S_i)
     i=S_i(ii);
     j=S_j(ii);
     fanshu=(DOTMN(i,j).x-DOTMN(jiedian_i,jiedian_j).x).^2+(DOTMN(i,j).z-DOTMN(jiedian_i,jiedian_j).z).^2;
     DOTMN(i,j).uptime=2*sqrt(fanshu)/(DOTMN(i,j).velocity+DOTMN(jiedian_i,jiedian_j).velocity);
%第五步：求S集合各结点的新旅行时
     tmin_panju=min(DOTMN(i,j).time,DOTMN(jiedian_i,jiedian_j).time+DOTMN(i,j).uptime);
     if tmin_panju<DOTMN(i,j).time
        DOTMN(i,j).time=tmin_panju;
        DOTMN(i,j).before_i=jiedian_i;
        DOTMN(i,j).before_j=jiedian_j;
     end
end
%第二步：找Q中一个旅行时最小的结点。
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
%第六步：将子波结点移动出集合Q并计算P集合结点的个数。
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


%第七部分判断结束结束。
%第八步：倒推出射线路径DOTMN().lujing_I与,DOTMN().lujing_J
%预备接收点循环。
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
              lu_panju=isnan(DOTMN(lu_i,lu_j).before_i);   %一直找到震源点为止
              counter_lu=counter_lu+1;
        end
        DOTMN(dotjie_i,dotjie_j).lujing_I=Xi;
        DOTMN(dotjie_i,dotjie_j).lujing_J=Zj;
        Xi=[];Zj=[];
    end
 
end
disp('!===== Ray Trace End =====!')
toc;
%第八步结束。

