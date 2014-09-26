# pierwsze całkowanie
x=linspace(-5,5,512);
dx=x(2)-x(1);
#sigma 1
sigma = 0.5;
conductance = 2;
sigma_n2=sigma^2;
three_sigma = 3*sigma;
obj.dim = 1
origin = 0

dim = 3;
if dim == 1
  y = (x-origin)/(sqrt(2)*sigma);
  r2 = y.^2;
  g = y.*erf(y) + exp(-r2)/sqrt(pi);
  g*=-0.5*sqrt(2)*sigma/conductance;
  g=g.*(y < 3/sqrt(2)*8);


  r2 = ((x-origin)/(sqrt(2)*sigma)).^2;
  f= 1./sqrt(2.*pi.*sigma_n2) .* exp(-r2) .* (sqrt(r2)< 3/sqrt(2)); 



  h=diff(g,2)/(dx^2);
  h=[h,0];
  h=[0,h];


  plot(x,-h, x,f/conductance,'.');
  #
  legend('-d^2/dx^2 V','Q/conductance');
end

# 2D
# TODO make a comparision between integral and analytical formula
if dim == 2
  y = (x-origin)/(sqrt(2)*sigma);
  r2 = y.^2;
  h = -sigma/(2*pi)*exp(-r2);
  g = sqrt(2)*expint(-r2) / (8*pi);

  y= (x-origin)/(sqrt(2)*sigma);
  r2 = y.^2;
  f= 1./(2.*pi.*sigma_n2) .* exp(-r2) .* (sqrt(r2)< 3/sqrt(2)); 

  g=diff(expint(-r2))/dx;
  g=[g,0].*sqrt(r2);
  g=diff(g)/dx;
  g=[0,h];
  g=h./(sqrt(r2)+eps)
  #plot(r2,expint(-r2))
  plot(x, g, x,h,'.');
end

if dim == 3
  r2 = (x-origin).^2;
  % kwadrat długości odległości
  g = 1.0./(4.0*pi*conductance*sqrt(r2+eps));
  g =g.* erf( sqrt(0.5*r2)/sigma);
  % regularisation
  g(1) = sqrt(g(2)*g(1));
  g=g.*(sqrt(r2) < three_sigma*8/3);

  % 3d prąd
  r2 = sum((x-origin).^2, 1)*0.5/sigma_n2;
  f = 1./sqrt(2.*pi.*sigma_n2)^3 .* exp(-r2) .* (sqrt(r2)<3/sqrt(2)); 
 

  h=-diff(sqrt(r2).*g, 2)./(dx^2);
  h=[0,h,0]./sqrt(r2);
  plot(x,f,'.',x,h*conductance,x,g);
end

axis([-1,2.5,0,1]);
legend('-d^2/dx^2 V','Q/conductance');
