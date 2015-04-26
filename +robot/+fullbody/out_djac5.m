function [djac] = out_djac5(q,dq)

  djac(1,1)=0;
  djac(1,2)=0;
  djac(1,3)=dq(3)*(sin(q(3) + q(4) + q(5)) + sin(q(3) + q(4)) + sin(q(3))) + dq(5)*sin(q(3) + q(4) +...
          q(5)) + dq(4)*(sin(q(3) + q(4) + q(5)) + sin(q(3) + q(4)));
  djac(1,4)=dq(5)*sin(q(3) + q(4) + q(5)) + dq(3)*(sin(q(3) + q(4) + q(5)) + sin(q(3) + q(4))) +...
          dq(4)*(sin(q(3) + q(4) + q(5)) + sin(q(3) + q(4)));
  djac(1,5)=dq(4)*(sin(q(3) + q(4) + q(5)) + sin(q(3) + q(4)) - cos(q(3))*sin(q(4)) - cos(q(4))*...
         sin(q(3))) + dq(3)*(sin(q(3) + q(4) + q(5)) + sin(q(3) + q(4)) + sin(q(3)) - cos(q(3))*sin(q(4)) - 2*cos(q(4))*...
         sin(q(3)) + sin(q(3))*(cos(q(4)) - 1)) + dq(5)*sin(q(3) + q(4) + q(5));
  djac(1,6)=0;
  djac(1,7)=0;
  djac(1,8)=0;
  djac(1,9)=0;
  djac(1,10)=0;
  djac(1,11)=0;
  djac(2,1)=0;
  djac(2,2)=0;
  djac(2,3)=0;
  djac(2,4)=0;
  djac(2,5)=0;
  djac(2,6)=0;
  djac(2,7)=0;
  djac(2,8)=0;
  djac(2,9)=0;
  djac(2,10)=0;
  djac(2,11)=0;
  djac(3,1)=0;
  djac(3,2)=0;
  djac(3,3)=dq(3)*(cos(q(3) + q(4) + q(5)) + cos(q(3) + q(4)) + cos(q(3))) + dq(5)*cos(q(3) + q(4) +...
          q(5)) + dq(4)*(cos(q(3) + q(4) + q(5)) + cos(q(3) + q(4)));
  djac(3,4)=dq(5)*cos(q(3) + q(4) + q(5)) + dq(3)*(cos(q(3) + q(4) + q(5)) + cos(q(3) + q(4))) +...
          dq(4)*(cos(q(3) + q(4) + q(5)) + cos(q(3) + q(4)));
  djac(3,5)=dq(4)*(cos(q(3) + q(4) + q(5)) + cos(q(3) + q(4)) - cos(q(3))*cos(q(4)) + sin(q(3))*...
         sin(q(4))) + dq(3)*(cos(q(3) + q(4) + q(5)) + cos(q(3) + q(4)) + cos(q(3)) - 2*cos(q(3))*cos(q(4)) + sin(q(3))*...
         sin(q(4)) + cos(q(3))*(cos(q(4)) - 1)) + dq(5)*cos(q(3) + q(4) + q(5));
  djac(3,6)=0;
  djac(3,7)=0;
  djac(3,8)=0;
  djac(3,9)=0;
  djac(3,10)=0;
  djac(3,11)=0;

 