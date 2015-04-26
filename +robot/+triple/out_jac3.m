function [jac] = out_jac3(q)

  jac(1,1)=cos(q(1) + q(2) + q(3)) + cos(q(1) + q(2)) + cos(q(1));
  jac(1,2)=cos(q(1) + q(2) + q(3)) + cos(q(1) + q(2));
  jac(1,3)=cos(q(1) + q(2) + q(3)) + cos(q(1) + q(2)) + cos(q(1)) - 2*cos(q(1))*cos(q(2)) +...
          sin(q(1))*sin(q(2)) + cos(q(1))*(cos(q(2)) - 1);
  jac(2,1)=0;
  jac(2,2)=0;
  jac(2,3)=0;
  jac(3,1)=- sin(q(1) + q(2) + q(3)) - sin(q(1) + q(2)) - sin(q(1));
  jac(3,2)=- sin(q(1) + q(2) + q(3)) - sin(q(1) + q(2));
  jac(3,3)=cos(q(1))*sin(q(2)) - sin(q(1) + q(2)) - sin(q(1)) - sin(q(1) + q(2) + q(3)) + 2*...
         cos(q(2))*sin(q(1)) - sin(q(1))*(cos(q(2)) - 1);

 