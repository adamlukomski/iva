function [djac_dq] = out_djac_dq11(q,dq)

  djac_dq(1,1)=dq(11)^2*q(1) - dq(11)^2*(q(1) - sin(q(11))) - dq(2)*dq(11);
  djac_dq(2,1)=0;
  djac_dq(3,1)=dq(1)*dq(11) - dq(11)^2*(q(2) - cos(q(11))) + dq(11)^2*q(2);

 