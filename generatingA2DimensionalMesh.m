function generatingA2DimensionalMesh( hornum,vernum,gridsize)
%本程序用于生成带索引二维网格
% hornum;%横坐标网格数
%vernum;%纵坐标网格数
%gridsize;%网格大小
clc;close all;
t1=cputime;
x = (0:hornum)*gridsize;%x点坐标
y = (0:vernum)*gridsize;%y点坐标
[Py,Y] = meshgrid(x,y);
line(Py,Y,'color','b');
line(Py',Y','color','b');
axis tight;axis equal;
%axis([0 hornum*gridsize 0 varnum*gridsize]);
set(gca,'xtick',0:gridsize:hornum*gridsize);
set(gca,'ytick',0:gridsize:vernum*gridsize);
gridindex = reshape(1:hornum*vernum,hornum,vernum)';
numposx = 0.5*(Py(1:end-1,2:end)+Py(1:end-1,1:end-1))-gridsize/2;%网格索引值x坐标
numposy = 0.5*(Y(2:end,1:end-1)+Y(1:end-1,1:end-1));%网格索引值y坐标
% for i = 1 : hornum
%     for n = 1 : vernum
%         %text(numposx(i,n),numposy(i,n),num2str(gridindex(i,n)));%将索引值填入网格中
%     end
% end
hold on;
%以上都是在画网格画坐标画索引值





end

