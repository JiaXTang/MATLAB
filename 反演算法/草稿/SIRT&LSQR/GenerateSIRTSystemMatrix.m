%��������������ϵͳ����A
clc
clear
N=100;%ͼ���С N*N
Ma=12;%ɨ��Ƕ�����0,15,30��...��165�ȣ�
Md=ceil(N/sqrt(2))*2;%�������ķ���� 142��
NS=N*N;
MS=Ma*Md;%�ܹ��������� 1704
Ang=linspace(0,180-180/Ma,Ma)*pi/180;  %0-165�� ÿ���12��Ļ���ֵ
Dis=-Md/2:Md/2; %ɨ����Ϊ1 ��ΧΪ-71~71

X_Vector=-N/2:N/2;  %X�ķ�ΧΪ��-50~50
X_Vector1=ones(1,N+1);
XMap=X_Vector'*X_Vector1;%�õ�һ������
XMap=XMap';
YMap=-XMap';
%XMap��YMap�����Ǹ����õģ�


tic
RMap=zeros(Ma,N+1,N+1);%��ά����
for Ai=1:Ma %���߽Ƕ�
    RMap(Ai,:,:)=cos(Ang(Ai)).*XMap+sin(Ang(Ai)).*YMap;
end

A=zeros(NS,MS);       %ϵͳ����
for Ni=1:N%������
    for Nj=1:N %������
        for Ai=1:Ma %���߽Ƕ�
            DisPix=[RMap(Ai,Ni,Nj) RMap(Ai,Ni+1,Nj) RMap(Ai,Ni,Nj+1) RMap(Ai,Ni+1,Nj+1)];
            DisPixMax=max(DisPix);
            DisPixMin=min(DisPix);
            DisInd=find((Dis<=DisPixMax) &(Dis>DisPixMin));
            if ~isempty(DisInd)
                PixInd=(Ni-1)*N+Nj;
                for DisIndi=1:length(DisInd)
                    ProInd=(Ai-1)*Md+DisInd(DisIndi);
                    
                    
                    DisPixDiff=DisPix-Dis(DisInd(DisIndi));
                    if Ang(Ai)==0 || Ang(Ai)==pi/2;
                        A(PixInd,ProInd)=1;     
                    else
                        LineD=Dis(DisInd(DisIndi));
                        y1=YMap(Ni,Nj);
                        x1=LineD/cos(Ang(Ai))-tan(Ang(Ai))*y1;
                        y2=YMap(Ni+1,Nj);
                        x2=LineD/cos(Ang(Ai))-tan(Ang(Ai))*y2;
                        x3=XMap(Ni,Nj);
                        y3=LineD/sin(Ang(Ai))-cot(Ang(Ai))*x3;
                        x4=XMap(Ni,Nj+1);
                        y4=LineD/sin(Ang(Ai))-cot(Ang(Ai))*x3;
                        
                        xs=[x1 x2 x3 x4];
                        ys=[y1 y2 y3 y4];
                        xs=sort(xs);ys=sort(ys);
                        Weight=sqrt((xs(2)-xs(3))^2+(ys(2)-ys(3))^2);
                        A(PixInd,ProInd)=Weight;   
                        
                    end    
%                     A(PixInd,ProInd)=1;                    
                    
                end
            end
            
        end
    end
end
NonZInd=find(A~=0);
Number=length(NonZInd)

toc