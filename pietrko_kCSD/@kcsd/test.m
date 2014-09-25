# pierwsze całkowanie
x=linspace(-1.2,1.2,1024);
dx=x(2)-x(1);
#sigma 1
sigma = 0.5;
conductance = 2;
sigma_n2=sigma^2;
three_sigma = 3*sigma;
obj.dim = 1
origin = 0

dim = 2;
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
axis([-1,1.5]);
legend('-d^2/dx^2 V','Q/conductance');
