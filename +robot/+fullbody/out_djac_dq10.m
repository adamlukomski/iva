function [djac_dq] = out_djac_dq10(q,dq)

  djac_dq(1,1)=dq(10)^2*q(1) - dq(10)^2*(q(1) - sin(q(10))) - dq(2)*dq(10);
  djac_dq(2,1)=0;
  djac_dq(3,1)=dq(1)*dq(10) - dq(10)^2*(q(2) - cos(q(10))) + dq(10)^2*q(2);

 