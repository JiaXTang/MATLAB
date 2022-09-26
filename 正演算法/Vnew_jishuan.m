function [V_i,V_j]=Vnew_jishuan(x,y,m,n)
%        [V_i,V_j]=Vnew_jishuan(pi,pj,j,m,n)
%  ����ȷ���Ӳ�Դ�����ڵĽ�����������н�㼯��V
%  ���V_i��V_j �ֱ�Ϊ���Ӳ�Դ�����ڵĽ�����������н�����������������
%  input : x��y �ֱ�Ϊ�Ӳ�Դ�����ڵĽ��������к����кţ�m��n Ϊ��ɢ����������
%% case 1 : four ex point 

if(x==1 & y ==1)
    V_i = [x x+1 x+1];
    V_j = [y+1 y y+1];
%   
elseif(x==m & y==1)
    V_i = [m-1 m-1 m];
    V_j = [y y+1 y+1];
%     
elseif(x==1 & y==n)
    V_i = [1 2 2];
    V_j = [n-1 n-1 n];
 % 
elseif(x==m & y==n)
    V_i = [m-1 m-1 m];
    V_j = [n n-1 n-1];
    
%% left vertix line
elseif((y==1&(x ~=1))|(y==1&(x ~=m)))
    V_i = [x-1 x-1 x x+1 x+1];
    V_j = [1 2 2 2 1];
% right vertix line 
elseif((y==n&x ~=1)|(y==n&x ~=m))
    V_i = [x-1 x-1 x x+1 x+1];
    V_j = [n-1 n-1 n n+1 n+1 ];
% top horizontal line
elseif((x==1&y ~=1)|(x==1&y ~=n))
    V_i = [1 2 2 2 1];
    V_j = [y-1 y-1 y y+1 y+1];
% bottom horizontal line
elseif((x==n&y~=1)|(x==n&y~=n))
    V_i = [m m-1 m-1 m-1 m];
    V_j = [y-1 y-1 y y+1 y+1];
else
    V_i = [x-1 x-1 x-1 x x+1 x+1 x+1 x];
    V_j = [y-1 y y+1 y+1 y+1 y y-1 y-1];
end
return
end

