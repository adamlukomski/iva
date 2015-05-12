function [djac] = out_djac1(q,dq)

  djac(1,1)=-dq(1)*sin(q(1));
  djac(1,2)=0;
  djac(2,1)=0;
  djac(2,2)=0;
  djac(3,1)=-dq(1)*cos(q(1));
  djac(3,2)=0;

 