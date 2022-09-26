%本程序用于生成单条直射线的系统矩阵
function [ A ] = Untitled( hornum,vernum,gridsize,Pp,Pq)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说
% hornum;%横坐标网格数
% vernum;%纵坐标网格数
% gridsize;%网格大小
%Pp=[x0,y0];%发射点坐标
%Pq=[x1,y1];%%接收点坐标


A=[];%代求系统矩阵

Pp_x = Pp(1);
Pp_y = Pp(2);
Pq_x = Pq(1);
Pq_y = Pq(2);
if(Pq_x~=Pp_x&&Pp_y~=Pq_y)
    K(1)=(Pq_y-Pp_y)/(Pq_x-Pp_x);%斜率
    K(2)=Pp_y-K(1)*Pp_x;%截距
    if(Pp_x>hornum*gridsize)
        Pp_x=hornum*gridsize;
        Pp_y=K(1)*Pp_x+K(2);
    end
    if(Pp_x<0)
        Pp_x=0;
        Pp_y=K(2);
    end
    if(Pp_y>vernum*gridsize)
        Pp_y=vernum*gridsize;
        Pp_x=(Pp_y-K(2))/K(1);
    end
    if(Pp_y<0)
        Pp_y=0;
        Pp_x=(Pp_y-K(2))/K(1);
    end
    if(Pq_x>hornum*gridsize)
        Pq_x=hornum*gridsize;
        Pq_y=K(1)*Pq_x+K(2);
    end
    if(Pq_x<0)
        Pq_x=0;
        Pq_y=K(2);
    end
    if(Pq_y>vernum*gridsize)
        Pq_y=vernum*gridsize;
        Pq_x=(Pq_y-K(2))/K(1);
    end
    if(Pq_y<0)
        Pq_y=0;
        Pq_x=(Pq_y-K(2))/K(1);
    end  
end

if(Pq_x==Pp_x)
    if(Pq_x>hornum*gridsize||Pq_x<0)
        %error!!!
    end
    if(Pq_y>vernum*gridsize)
        Pq_y=vernum*gridsize;
    end
    if(Pp_y>vernum*gridsize)
        Pp_y=vernum*gridsize;
    end
    if(Pq_y<0)
        Pq_y=0;
    end
    if(Pp_y<0)
        Pp_y=0;
    end
end


if(Pq_y==Pp_y)
    if(Pq_y>vernum*gridsize||Pq_y<0)
        %error!!!
    end
    if(Pq_x>hornum*gridsize)
        Pq_x=hornum*gridsize;
    end
    if(Pp_x>hornum*gridsize)
        Pp_x=hornum*gridsize;
    end
    if(Pq_x<0)
        Pq_x=0;
    end
    if(Pp_x<0)
        Pp_x=0;
    end
end



        
        xmin = min(Pp_x,Pq_x);
        ymin = min(Pp_y,Pq_y);
        xmax = max(Pp_x,Pq_x);
        ymax = max(Pp_y,Pq_y);
        
        pos = reshape(1:hornum*vernum,hornum,vernum);
        S=zeros(hornum,vernum);%S置零
        S1=zeros(hornum,vernum);
        if (Pp_x ~= Pq_x)
            K(1)=(Pq_y-Pp_y)/(Pq_x-Pp_x);%斜率
            K(2)=Pp_y-K(1)*Pp_x;%截距
            %K = polyfit([Pp_x,Pq_x],[Pp_y,Pq_y],1);%求直线斜率与截距
            xpx = []; xpy = [];
            %取x坐标时，求y值
            i=(fix(xmin/gridsize)+1)*gridsize;
            if fix(xmin/gridsize)<=xmin/gridsize&&fix(xmax/gridsize)<xmax/gridsize
                for f=1:fix(xmax/gridsize)-fix(xmin/gridsize)
                    xpx(f) = i;
                    xpy(f) = K(1)*i+K(2);
                    i=i+gridsize;
                end
            elseif fix(xmin/gridsize)<=xmin/gridsize&&fix(xmax/gridsize)==xmax/gridsize
                
                for f=1:fix(xmax/gridsize)-fix(xmin/gridsize)-1
                    xpx(f) = i;
                    xpy(f) = K(1)*i+K(2);
                    i=i+gridsize;
                end
            end
            j=(fix(ymin/gridsize)+1)*gridsize;
            ypx = [];ypy = [];
            if fix(ymin/gridsize)<=ymin/gridsize&&fix(ymax/gridsize)<ymax/gridsize
                for g=1:fix(ymax/gridsize)-fix(ymin/gridsize)
                    ypy(g) = j;
                    ypx(g) = (j- K(2))/K(1);
                    j=j+gridsize;
                end
            elseif fix(ymin/gridsize)<=ymin/gridsize&&fix(ymax/gridsize)==ymax/gridsize
                for g=1:fix(ymax/gridsize)-fix(ymin/gridsize)-1
                    ypy(g) = j;
                    ypx(g) = (j- K(2))/K(1);
                    j=j+gridsize;
                end
            end
            SP = unique([Pp_x,Pq_x,xpx,ypx;Pp_y,Pq_y,xpy,ypy]','rows');%每一条线的所有x,y坐标
        elseif (Pp_x == Pq_x)
            ypx = [];ypy = [];
            j=(fix(ymin/gridsize)+1)*gridsize;
            if fix(ymin/gridsize)<=(ymin/gridsize)&&fix(ymax/gridsize)<(ymax/gridsize)
                for g=1:fix(ymax/gridsize)-fix(ymin/gridsize)
                    ypy(g) = j;
                    ypx(g) = Pq(1);
                    j=j+gridsize;
                end
            elseif fix(ymin/gridsize)<=ymin/gridsize&&fix(ymax/gridsize)==ymax/gridsize
                
                for g=1:fix(ymax/gridsize)-fix(ymin/gridsize)-1
                    ypy(g) = j;
                    ypx(g) = Pq(1);
                    j=j+gridsize;
                end
            end
            SP = unique([Pp_x,Pq_x,ypx;Pp_y,Pq_y,ypy]','rows');
        end
        
        for m =1:size(SP,1)-1 %红色线连上
            line([SP(m,1) SP(m+1,1)],[SP(m,2) SP(m+1,2)],'color','r');%画出每个格子中线段的长度
        end
        % L = @(x)sqrt((SP(x+1,1) - SP(x,1)).^2 + (SP(x+1,2) - SP(x,2)).^2);%计算每个格子中线段的长度
        
        
        %计算射线穿过哪些格子
        L=[];
        for t = 1 : size(SP,1)-1
            L(end+1) =sqrt((SP(t+1,1) - SP(t,1)).^2 + (SP(t+1,2) - SP(t,2)).^2);%计算每个格子中线段的长度
            segs(t).index_x = ceil(max(SP(t+1,1)/gridsize,SP(t,1)/gridsize));
            segs(t).index_y = ceil(max(SP(t+1,2)/gridsize,SP(t,2)/gridsize));
            if segs(t).index_x==0
                segs(t).index_x=1;
            end
            if segs(t).index_x>=hornum
                segs(t).index_x=hornum;
            end

            if segs(t).index_y==0
                segs(t).index_y=1;
            end
            if segs(t).index_y>=hornum
                segs(t).index_y=hornum;
            end
            segs(t).length = L(t);
            if(segs(t).index_y>=0&&segs(t).index_x>=0)
            S(segs(t).index_x, segs(t).index_y)=segs(t).length;
            end
        end
        S=reshape(S,1,hornum*vernum);
        for k=1:hornum*vernum%S的列索引值a
            A(1,k)=S(1,k);
        end



end

