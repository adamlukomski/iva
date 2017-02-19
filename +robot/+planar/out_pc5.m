function [pc] = out_pc5(q)

  pc(1,1)=q(1) - sin(q(3) + q(4) + q(5))/2 - sin(q(3) + q(4)) - sin(q(3));
  pc(2,1)=0;
  pc(3,1)=q(2) - cos(q(3) + q(4) + q(5))/2 - cos(q(3) + q(4)) - cos(q(3));
  pc(4,1)=1;

 