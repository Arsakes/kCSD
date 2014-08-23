function testReko(potential_test = 0)
% 
% Test diagonali: diagonala kernela powinna być
% sumą kwadratów funkcji bazowych 
% dla ustalonej siatki funkcji bazowych wiadomo jak to z grubsza 
% powinno wyglądać
%


params = [1/16,1.0];

% przygotowywanie siatki bazowej (tj. funkcji bazowych)
% siatka jest 8x8 dwuwymiarowa
n=16;
t=linspace(0,1,n);
[xx,yy]=meshgrid(t,t);
base_grid=[reshape(xx,1,n^2); reshape(yy,1,n^2); zeros(1,n^2)];
% siatka bazowa base zdefiniowana

% siatka próbkowania
l=7;
t=linspace(0,1,l);
[xx,yy]=meshgrid(t,t);
probing_grid=[reshape(xx,1,l^2); reshape(yy,1,l^2); zeros(1,l^2)];


% siatka wyjścia, m-elementów? obszar [0,1]x[0,1]x[0]
m=32;
t=linspace(0,1,m);
[xx,yy]=meshgrid(t,t);
out_grid=[reshape(xx,1,m^2); reshape(yy,1,m^2); zeros(1,m^2)];

%mesh(xx, yy, reshape(diag(K), m,m)),shading('interp');

% kernel do rysowania potencjału  

% definujemy sygnał - niech będzie płaski! kolumnowy wektor
V = ones(l^2,1);
% src_grid = out_grid = probing_grid (wyświatlamy w mscu pomiaru)
%C=calcCurrentK(probing_grid, out_grid, base_grid, params);
C = reconstruct(probing_grid, V ,out_grid , base_grid, params);

if potential_test == 1
  K = calcK(probing_grid, base_grid, params);
  Kout = calcK(probing_grid, base_grid, params, 'out_grid', out_grid);

  % liczenie prądu z potencjału większej liczbie punktów
  Vtest = transpose(Kout)*inv(K)*V;

 plot3(probing_grid(1,:), probing_grid(2,:), V,'.');
 hold on
 plot3(out_grid(1,:), out_grid(2,:), Vtest,'o','color','green');
 hold off
endif

if potential_test != 1
%pełen zrekonstruowany sygnał trzeba wyrysować m^2 punktów

plot3(out_grid(1,:), out_grid(2,:), C,'.');
hold on
plot3(out_grid(1,:), out_grid(2,:), C,'o','color','green');
hold off
endif

%tmp=reshape(tmp(:,1),8,8);
%figure(1);
%plot3(x1,x2,tmpC(:,1)+tmpC(:,64),'.');
%figure(2);
%axis([-1,65,-1,65]);
end
