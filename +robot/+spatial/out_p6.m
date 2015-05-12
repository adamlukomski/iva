function [p] = out_p6(q)

  p(1,1)=q(1) - cos(q(5))*sin(q(6));
  p(2,1)=q(2) + cos(q(6))*sin(q(4)) - cos(q(4))*sin(q(5))*sin(q(6));
  p(3,1)=q(3) - cos(q(4))*cos(q(6)) - sin(q(4))*sin(q(5))*sin(q(6));
  p(4,1)=1;

 