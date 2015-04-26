function [p] = out_p8(q)

  p(1,1)=q(1) - sin(q(3) + q(7) + q(8)) - sin(q(3) + q(7)) - sin(q(3));
  p(2,1)=0;
  p(3,1)=q(2) - cos(q(3) + q(7) + q(8)) - cos(q(3) + q(7)) - cos(q(3));
  p(4,1)=1;

 