function y=jmake_func(fname,a,b,N);x=linspace(a,b,N);%y=eval([ 'fname' '(' x ');']);y = sin(x);