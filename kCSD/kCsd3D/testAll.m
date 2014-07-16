function testAll()

params = [9,1.0];

% przygotowywanie siatki bazy
t=linspace(0,64,8);
[xx,yy]=meshgrid(t,t);
x1=reshape(xx,1,64);
x2=reshape(yy,1,64);
base=[reshape(xx,1,64); reshape(yy,1,64); zeros(1,64)];
%plot3(base(1,:), base(2,:), base(3,:),'.');
axis([-1,17,-1,17]);


tmpV=zeros(64,64);
tmpC=zeros(64,64);
% liczenie odległości
for i=1:64
  tmpV(:,i)=potential_base(base,base(:,i)*ones(1,64), params(1), params(2));
  tmpC(:,i)=current_base(base,base(:,i)*ones(1,64), params(1), params(2));
end


%tmp=reshape(tmp(:,1),8,8);
figure(1);
plot3(x1,x2,tmpC(:,1)+tmpC(:,64),'.');
figure(2);
tmpC=tmpC*transpose(tmpC);
size(tmpC)
plot3(x1,x2,inv(tmpC(:,:)),'.');

axis([-1,65,-1,65]);
end
