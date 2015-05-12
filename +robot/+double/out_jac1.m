function [jac] = out_jac1(q)

  jac(1,1)=cos(q(1));
  jac(1,2)=0;
  jac(2,1)=0;
  jac(2,2)=0;
  jac(3,1)=-sin(q(1));
  jac(3,2)=0;

 