function [g] = out_g6(q)

  g(1,1)=cos(q(5))*cos(q(6));
  g(1,2)=-sin(q(5));
  g(1,3)=cos(q(5))*sin(q(6));
  g(1,4)=q(1) - cos(q(5))*sin(q(6));
  g(2,1)=sin(q(4))*sin(q(6)) + cos(q(4))*cos(q(6))*sin(q(5));
  g(2,2)=cos(q(4))*cos(q(5));
  g(2,3)=cos(q(4))*sin(q(5))*sin(q(6)) - cos(q(6))*sin(q(4));
  g(2,4)=q(2) + cos(q(6))*sin(q(4)) - cos(q(4))*sin(q(5))*sin(q(6));
  g(3,1)=cos(q(6))*sin(q(4))*sin(q(5)) - cos(q(4))*sin(q(6));
  g(3,2)=cos(q(5))*sin(q(4));
  g(3,3)=cos(q(4))*cos(q(6)) + sin(q(4))*sin(q(5))*sin(q(6));
  g(3,4)=q(3) - cos(q(4))*cos(q(6)) - sin(q(4))*sin(q(5))*sin(q(6));
  g(4,1)=0;
  g(4,2)=0;
  g(4,3)=0;
  g(4,4)=1;

 