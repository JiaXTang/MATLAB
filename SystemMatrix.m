%��������������ϵͳ����
clc;close all;
t1=cputime;
hornum=30;%������������
vernum=30;%������������
gridsize=1;%�����С
generatingA2DimensionalMesh(hornum,vernum,gridsize);
%% ���ô�����
shuicheng=30;%ˮ��
Lchuangganqi=30;%����������
Dfashezhenyuan=3;%������Ԫ���
Dzhenyuan=3;%������Ԫ���
Ma=10;%��������ת�Ƕ�
coordinateMap=setSensor(hornum,gridsize,shuicheng,Lchuangganqi,Dfashezhenyuan,Dzhenyuan,Ma);%��ȡ��������꼰��Ӧ�Ľ��ܵ�����
Ang=linspace(0,180-180/Ma,Ma)*pi/180;%���нǶ� linspace�����ɵȾ�� 0-180��12���Ƕ�ֵ
%% ��ʼ��ϵͳ����A
A=[];
for iiii=1:length(Ang)
    xx=coordinateMap(:,iiii,1);yy=coordinateMap(:,iiii,2);
    mm=coordinateMap(:,iiii,3);nn=coordinateMap(:,iiii,4);
    for pp=1:length(xx)%�����곤�ȣ��������곤����ͬ��
    Pp=[xx(pp),yy(pp)];%�Ͽ���Ϊ�����
    Pq=[mm(pp),nn(pp)];%�¿���Ϊ�����
    Ai = systemMatrixOfOneRay(hornum,vernum,gridsize,Pp,Pq);  
    A=[A;Ai];
    end
end
