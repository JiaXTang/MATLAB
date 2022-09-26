%本程序用来生成系统矩阵
clc;close all;
t1=cputime;
hornum=30;%横坐标网格数
vernum=30;%纵坐标网格数
gridsize=1;%网格大小
generatingA2DimensionalMesh(hornum,vernum,gridsize);
%% 设置传感器
shuicheng=30;%水程
Lchuangganqi=30;%传感器长度
Dfashezhenyuan=3;%发射阵元间距
Dzhenyuan=3;%接收阵元间距
Ma=10;%传感器旋转角度
coordinateMap=setSensor(hornum,gridsize,shuicheng,Lchuangganqi,Dfashezhenyuan,Dzhenyuan,Ma);%获取发射点坐标及对应的接受点坐标
Ang=linspace(0,180-180/Ma,Ma)*pi/180;%所有角度 linspace是生成等距点 0-180里12个角度值
%% 开始求系统矩阵A
A=[];
for iiii=1:length(Ang)
    xx=coordinateMap(:,iiii,1);yy=coordinateMap(:,iiii,2);
    mm=coordinateMap(:,iiii,3);nn=coordinateMap(:,iiii,4);
    for pp=1:length(xx)%横坐标长度（与纵坐标长度相同）
    Pp=[xx(pp),yy(pp)];%上壳体为发射点
    Pq=[mm(pp),nn(pp)];%下壳体为发射点
    Ai = systemMatrixOfOneRay(hornum,vernum,gridsize,Pp,Pq);  
    A=[A;Ai];
    end
end
