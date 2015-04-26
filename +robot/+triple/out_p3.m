function [p] = out_p3(q)

  p(1,1)=sin(q(1) + q(2) + q(3)) + sin(q(1) + q(2)) + sin(q(1));
  p(2,1)=0;
  p(3,1)=cos(q(1) + q(2) + q(3)) + cos(q(1) + q(2)) + cos(q(1));
  p(4,1)=1;

 