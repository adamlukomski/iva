function [p] = out_p6(q)

  p(1,1)=q(1) - sin(q(3) + q(4) + q(5)) + cos(q(3) + q(4) + q(5) + q(6))/5 - sin(q(3) + q(4)) - sin(q(3));
  p(2,1)=0;
  p(3,1)=q(2) - cos(q(3) + q(4) + q(5)) - sin(q(3) + q(4) + q(5) + q(6))/5 - cos(q(3) + q(4)) - cos(q(3));
  p(4,1)=1;

 