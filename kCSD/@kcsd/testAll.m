function testAll(obj)
% 
% Test diagonali: diagonala kernela powinna być
% sumą kwadratów funkcji bazowych 
% dla ustalonej siatki funkcji bazowych wiadomo jak to z grubsza 
% powinno wyglądać
%


params = [1/16,1];

% przygotowywanie siatki bazowej (tj. funkcji bazowych)
% siatka jest 8x8 dwuwymiarowa
n=16
t=linspace(0,1,n);
[xx,yy]=meshgrid(t,t);
base=[reshape(xx,1,n^2); reshape(yy,1,n^2); zeros(1,n^2)];
base=[base,[base(1,:);base(2,:); base(3,:)+1 ] ];
% siatka bazowa base zdefiniowana


% siatka próbkowania
m=32;
t=linspace(0,1,m);
[xx,yy]=meshgrid(t,t);
probing_grid=[reshape(xx,1,m^2); reshape(yy,1,m^2); zeros(1,m^2)];

% there could be if case
K=calcK(obj, probing_grid, base, params);
%K=calcCurrentK(probing_grid, probing_grid, base,params);
% diagonalą kernela będzie kwadrat funkcji bazowych
% rozlokowanych w całości siatki
%size(null(K))
mesh(xx, yy, reshape(diag(K), m,m)),shading('interp');

%tmpV=zeros(64,64);
%tmpC=zeros(64,64);
% liczenie odległości
%for i=1:64
%  tmpV(:,i)=potential_base(base,base(:,i)*ones(1,64), params(1), params(2));
%  tmpC(:,i)=current_base(base,base(:,i)*ones(1,64), params(1), params(2));
%end


%tmp=reshape(tmp(:,1),8,8);
%figure(1);
%plot3(x1,x2,tmpC(:,1)+tmpC(:,64),'.');
%figure(2);
%tmpC=tmpC*transpose(tmpC);
%size(tmpC)
%plot3(x1,x2,inv(tmpC(:,:)),'.');

%axis([-1,65,-1,65]);
end
