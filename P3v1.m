%%Team memebers Adarsh Chitradurga Achutha, Gaurish Sharma
clear all;

clc;

chk1='Please enter the number of cities (N) :';
N=input(chk1);
Rd=@(x1,y1,x2,y2)(sqrt(((x2-x1)^2)+((y2-y1)^2)));

%% generation of the N coordinates

XY=100*rand(N,2);
XY1=[];
for i=1:N
    XY1=[XY1;i XY(i,:)];
end
k=length(XY1(:,1));
G=zeros(k,k);

for i=1:length(XY1(:,1))
    for j=1:length(XY1(:,1))
        if i~=j
            G(i,j)=Rd(XY1(i,2),XY1(j,2),XY1(i,3),XY1(j,3));
        end
    end
end
R=[];
D=[];
Row=transpose(XY1(:,1));
[H,K]=dynamicTSP(G,Row,length(G(:,1)),R,D);

function [B,D1]=dynamicTSP(XY,Row,Nr,R,D)
G=XY;
t=Nr;

if length(G(:,1))==length(Row(1,:)) && length(Row(1,:))>1
    U=[];
    U2=[];
    for i=2:t
        J=Row;
        J(:,1)=[];
        [L,K]=dynamicTSP(XY,J,Nr,R,D);
        U2=[U2; L(1,:)];
        dist=XY(1,i)+K;
        U=[U; dist];
        
    end
    [val, k]=min(U)
    B=[U2(k,:);R]
    D1=val

if length(Row(1,:))>1
    U=[];
    U1=[];
    for i=2:length(Row(1,:))
        Dum=Row;
        Dum(:,i)=[];
        [L,K]=dynamicTSP(XY,Dum,Nr,R,D);
        
        dist=XY(Row(1,i),L(1,1))+K;
        U=[U; L(1,:)];        
        U1=[U1; dist];
    end
    [val, k]=min(U1)
    B=[U(k,:);R]
    D1=val
else    
    B=[2 1;R]
    D1=D+G(1,2)


end
end

end


    


