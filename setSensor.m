function [ coordinateMap ] = setSensor( hornum,gridsize,shuicheng,Lchuangganqi,Dfashezhenyuan,Dzhenyuan,Ma )
%此程序用于生成三维矩阵（线列阵的坐标位置）分别为x0,y0,x1,y1的合并
% hornum 横向网格数
% gridsize 网格尺寸
% shuicheng 水程
%Lchuangganqi 传感器长度
%Dfashezhenyuan 发射阵元间距
%Dzhenyuan 接收阵元间距
%Ma 传感器旋转角度

Nfashezhenyuanfenbu=0:Lchuangganqi/Dfashezhenyuan;%阵元数
%接收阵元设置
Nzhenyuanfenbu=0:Lchuangganqi/Dzhenyuan;%阵元数

Ang=linspace(0,180-180/Ma,Ma)*pi/180;%所有角度 linspace是生成等距点 0-180里12个角度值



r = shuicheng*gridsize/2;%半径
a = hornum*gridsize/2;%圆心横坐标
b = hornum*gridsize/2;%圆心纵坐标

%计算上壳体的横纵坐标
xxCen3=[];yyCen3=[];xxCen4=[];yyCen4=[];
for i=1:length(Ang)
    for j=1:length(Nfashezhenyuanfenbu)-1
        x3= a-r*cos(Ang(i))-Lchuangganqi/2*gridsize*sin(Ang(i))+(j-1)*Dfashezhenyuan*gridsize*sin(Ang(i))+Dfashezhenyuan*gridsize*sin(Ang(i))/2;
        xxCen3(end+1)=x3;
        y3 = b+r*sin(Ang(i))-Lchuangganqi/2*gridsize*cos(Ang(i))+(j-1)*Dfashezhenyuan*gridsize*cos(Ang(i))+Dfashezhenyuan*gridsize*cos(Ang(i))/2;
        yyCen3(end+1)=y3;
    end
     %plot(xxCen3,yyCen3,'-');
end
%计算下壳体的横纵坐标
for i=1:length(Ang)
    for j=1:length(Nzhenyuanfenbu)-1
        x4= a+r*cos(Ang(i))-Lchuangganqi/2*gridsize*sin(Ang(i))+(j-1)*Dzhenyuan*gridsize*sin(Ang(i))+Dzhenyuan*gridsize*sin(Ang(i))/2;
        xxCen4(end+1)=x4;
        y4 = b-r*sin(Ang(i))-Lchuangganqi/2*gridsize*cos(Ang(i))+(j-1)*Dzhenyuan*gridsize*cos(Ang(i))+Dzhenyuan*gridsize*cos(Ang(i))/2;
        yyCen4(end+1)=y4;
    end
    %plot(xxCen4,yyCen4,'-');
end
xxMap=reshape(xxCen3,length(Nfashezhenyuanfenbu)-1,length(Ang));
yyMap=reshape(yyCen3,length(Nfashezhenyuanfenbu)-1,length(Ang));
xxMap1=reshape(xxCen4,length(Nzhenyuanfenbu)-1,length(Ang));
yyMap1=reshape(yyCen4,length(Nzhenyuanfenbu)-1,length(Ang));
coordinateMap=cat(3,xxMap,yyMap,xxMap1,yyMap1);%组合成三维矩阵
end

