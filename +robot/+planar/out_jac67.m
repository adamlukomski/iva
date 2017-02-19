function [jac6] = out_jac67(q)

  jac6(1,1)=0;
  jac6(1,2)=0;
  jac6(1,3)=0;
  jac6(1,4)=0;
  jac6(1,5)=0;
  jac6(1,6)=0;
  jac6(1,7)=0;
  jac6(2,1)=0;
  jac6(2,2)=0;
  jac6(2,3)=1;
  jac6(2,4)=0;
  jac6(2,5)=0;
  jac6(2,6)=1;
  jac6(2,7)=1;
  jac6(3,1)=0;
  jac6(3,2)=0;
  jac6(3,3)=0;
  jac6(3,4)=0;
  jac6(3,5)=0;
  jac6(3,6)=0;
  jac6(3,7)=0;
  jac6(4,1)=1;
  jac6(4,2)=0;
  jac6(4,3)=- cos(q(3) + q(6) + q(7)) - cos(q(3) + q(6)) - cos(q(3));
  jac6(4,4)=0;
  jac6(4,5)=0;
  jac6(4,6)=- cos(q(3) + q(6) + q(7)) - cos(q(3) + q(6));
  jac6(4,7)=2*cos(q(3))*cos(q(6)) - cos(q(3) + q(6)) - cos(q(3)) - cos(q(3) + q(6) + q(7)) -...
          sin(q(3))*sin(q(6)) - cos(q(3))*(cos(q(6)) - 1);
  jac6(5,1)=0;
  jac6(5,2)=0;
  jac6(5,3)=0;
  jac6(5,4)=0;
  jac6(5,5)=0;
  jac6(5,6)=0;
  jac6(5,7)=0;
  jac6(6,1)=0;
  jac6(6,2)=1;
  jac6(6,3)=sin(q(3) + q(6) + q(7)) + sin(q(3) + q(6)) + sin(q(3));
  jac6(6,4)=0;
  jac6(6,5)=0;
  jac6(6,6)=sin(q(3) + q(6) + q(7)) + sin(q(3) + q(6));
  jac6(6,7)=sin(q(3) + q(6) + q(7)) + sin(q(3) + q(6)) + sin(q(3)) - cos(q(3))*sin(q(6)) - 2*...
         cos(q(6))*sin(q(3)) + sin(q(3))*(cos(q(6)) - 1);

 