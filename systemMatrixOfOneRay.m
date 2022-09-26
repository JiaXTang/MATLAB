%�������������ɵ���ֱ���ߵ�ϵͳ����
function [ A ] = Untitled( hornum,vernum,gridsize,Pp,Pq)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵
% hornum;%������������
% vernum;%������������
% gridsize;%�����С
%Pp=[x0,y0];%���������
%Pq=[x1,y1];%%���յ�����


A=[];%����ϵͳ����

Pp_x = Pp(1);
Pp_y = Pp(2);
Pq_x = Pq(1);
Pq_y = Pq(2);
if(Pq_x~=Pp_x&&Pp_y~=Pq_y)
    K(1)=(Pq_y-Pp_y)/(Pq_x-Pp_x);%б��
    K(2)=Pp_y-K(1)*Pp_x;%�ؾ�
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
        S=zeros(hornum,vernum);%S����
        S1=zeros(hornum,vernum);
        if (Pp_x ~= Pq_x)
            K(1)=(Pq_y-Pp_y)/(Pq_x-Pp_x);%б��
            K(2)=Pp_y-K(1)*Pp_x;%�ؾ�
            %K = polyfit([Pp_x,Pq_x],[Pp_y,Pq_y],1);%��ֱ��б����ؾ�
            xpx = []; xpy = [];
            %ȡx����ʱ����yֵ
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
            SP = unique([Pp_x,Pq_x,xpx,ypx;Pp_y,Pq_y,xpy,ypy]','rows');%ÿһ���ߵ�����x,y����
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
        
        for m =1:size(SP,1)-1 %��ɫ������
            line([SP(m,1) SP(m+1,1)],[SP(m,2) SP(m+1,2)],'color','r');%����ÿ���������߶εĳ���
        end
        % L = @(x)sqrt((SP(x+1,1) - SP(x,1)).^2 + (SP(x+1,2) - SP(x,2)).^2);%����ÿ���������߶εĳ���
        
        
        %�������ߴ�����Щ����
        L=[];
        for t = 1 : size(SP,1)-1
            L(end+1) =sqrt((SP(t+1,1) - SP(t,1)).^2 + (SP(t+1,2) - SP(t,2)).^2);%����ÿ���������߶εĳ���
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
        for k=1:hornum*vernum%S��������ֵa
            A(1,k)=S(1,k);
        end



end

