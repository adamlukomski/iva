function [p] = out_p10(q)

  p(1,1)=q(1) - sin(q(10));
  p(2,1)=0;
  p(3,1)=q(2) - cos(q(10));
  p(4,1)=1;

 