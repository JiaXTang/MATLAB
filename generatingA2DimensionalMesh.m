function generatingA2DimensionalMesh( hornum,vernum,gridsize)
%�������������ɴ�������ά����
% hornum;%������������
%vernum;%������������
%gridsize;%�����С
clc;close all;
t1=cputime;
x = (0:hornum)*gridsize;%x������
y = (0:vernum)*gridsize;%y������
[Py,Y] = meshgrid(x,y);
line(Py,Y,'color','b');
line(Py',Y','color','b');
axis tight;axis equal;
%axis([0 hornum*gridsize 0 varnum*gridsize]);
set(gca,'xtick',0:gridsize:hornum*gridsize);
set(gca,'ytick',0:gridsize:vernum*gridsize);
gridindex = reshape(1:hornum*vernum,hornum,vernum)';
numposx = 0.5*(Py(1:end-1,2:end)+Py(1:end-1,1:end-1))-gridsize/2;%��������ֵx����
numposy = 0.5*(Y(2:end,1:end-1)+Y(1:end-1,1:end-1));%��������ֵy����
% for i = 1 : hornum
%     for n = 1 : vernum
%         %text(numposx(i,n),numposy(i,n),num2str(gridindex(i,n)));%������ֵ����������
%     end
% end
hold on;
%���϶����ڻ��������껭����ֵ





end

