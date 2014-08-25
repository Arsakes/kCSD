function testReko(potential_test)
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
l=8;
t=linspace(0,1,l);
[xx,yy]=meshgrid(t,t);
src_grid=[reshape(xx,1,l^2); reshape(yy,1,l^2); zeros(1,l^2)];


% siatka wyjścia, m-elementów? obszar [0,1]x[0,1]x[0]
m=32;
t=linspace(0,1,m);
[xx,yy]=meshgrid(t,t);
out_grid=[reshape(xx,1,m^2); reshape(yy,1,m^2); zeros(1,m^2)];


% definujemy sygnał - niech będzie płaski! kolumnowy wektor
V = ones(l^2,1);


% klasa kcsd
obj = kcsd(params, src_grid, out_grid, base_grid, V);

%pełen zrekonstruowany sygnał trzeba wyrysować m^2 punktów
obj=reconstruct(obj);
figure(1)
title('CSD reconstruction from flat potential');
plot3(out_grid(1,:), out_grid(2,:), obj.CSD,'.');



% POTENTIAL INTERPOLATION TEST
% from 49 points to 1024
K=obj.kernel;
obj = recalcKernels(obj, 'interp_grid', out_grid);

%size(V)
%size(obj.kernel)
%size(obj.prePin)
%size(obj.prePout)

% liczenie prądu z potencjału większej liczbie punktów
Vtest = transpose(obj.kernel)*inv(K)*V;
figure(2)
plot3(src_grid(1,:), src_grid(2,:), V,'.');
hold on
plot3(out_grid(1,:), out_grid(2,:), Vtest,'o','color','green');
hold off



end
