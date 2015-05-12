function [jac6] = out_jac62(q)

  jac6(1,1)=0;
  jac6(1,2)=0;
  jac6(2,1)=1;
  jac6(2,2)=1;
  jac6(3,1)=0;
  jac6(3,2)=0;
  jac6(4,1)=cos(q(1) + q(2)) + cos(q(1));
  jac6(4,2)=cos(q(1) + q(2));
  jac6(5,1)=0;
  jac6(5,2)=0;
  jac6(6,1)=- sin(q(1) + q(2)) - sin(q(1));
  jac6(6,2)=-sin(q(1) + q(2));

 