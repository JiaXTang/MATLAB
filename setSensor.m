function [ coordinateMap ] = setSensor( hornum,gridsize,shuicheng,Lchuangganqi,Dfashezhenyuan,Dzhenyuan,Ma )
%�˳�������������ά���������������λ�ã��ֱ�Ϊx0,y0,x1,y1�ĺϲ�
% hornum ����������
% gridsize ����ߴ�
% shuicheng ˮ��
%Lchuangganqi ����������
%Dfashezhenyuan ������Ԫ���
%Dzhenyuan ������Ԫ���
%Ma ��������ת�Ƕ�

Nfashezhenyuanfenbu=0:Lchuangganqi/Dfashezhenyuan;%��Ԫ��
%������Ԫ����
Nzhenyuanfenbu=0:Lchuangganqi/Dzhenyuan;%��Ԫ��

Ang=linspace(0,180-180/Ma,Ma)*pi/180;%���нǶ� linspace�����ɵȾ�� 0-180��12���Ƕ�ֵ



r = shuicheng*gridsize/2;%�뾶
a = hornum*gridsize/2;%Բ�ĺ�����
b = hornum*gridsize/2;%Բ��������

%�����Ͽ���ĺ�������
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
%�����¿���ĺ�������
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
coordinateMap=cat(3,xxMap,yyMap,xxMap1,yyMap1);%��ϳ���ά����
end

