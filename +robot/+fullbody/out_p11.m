function [p] = out_p11(q)

  p(1,1)=q(1) - sin(q(11));
  p(2,1)=0;
  p(3,1)=q(2) - cos(q(11));
  p(4,1)=1;

 