function [jac] = out_jac7(q)

  jac(1,1)=1;
  jac(1,2)=0;
  jac(1,3)=- cos(q(3) + q(6) + q(7)) - cos(q(3) + q(6)) - cos(q(3));
  jac(1,4)=0;
  jac(1,5)=0;
  jac(1,6)=- cos(q(3) + q(6) + q(7)) - cos(q(3) + q(6));
  jac(1,7)=2*cos(q(3))*cos(q(6)) - cos(q(3) + q(6)) - cos(q(3)) - cos(q(3) + q(6) + q(7)) -...
          sin(q(3))*sin(q(6)) - cos(q(3))*(cos(q(6)) - 1);
  jac(2,1)=0;
  jac(2,2)=0;
  jac(2,3)=0;
  jac(2,4)=0;
  jac(2,5)=0;
  jac(2,6)=0;
  jac(2,7)=0;
  jac(3,1)=0;
  jac(3,2)=1;
  jac(3,3)=sin(q(3) + q(6) + q(7)) + sin(q(3) + q(6)) + sin(q(3));
  jac(3,4)=0;
  jac(3,5)=0;
  jac(3,6)=sin(q(3) + q(6) + q(7)) + sin(q(3) + q(6));
  jac(3,7)=sin(q(3) + q(6) + q(7)) + sin(q(3) + q(6)) + sin(q(3)) - cos(q(3))*sin(q(6)) - 2*...
         cos(q(6))*sin(q(3)) + sin(q(3))*(cos(q(6)) - 1);

 