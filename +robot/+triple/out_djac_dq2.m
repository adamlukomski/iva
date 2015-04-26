function [djac_dq] = out_djac_dq2(q,dq)

  djac_dq(1,1)=dq(2)^2*sin(q(1)) - (dq(1)^2 + dq(2)^2)*(sin(q(1) + q(2)) + sin(q(1))) + dq(1)*dq(2)*sin(q(1));
  djac_dq(2,1)=0;
  djac_dq(3,1)=dq(2)^2*cos(q(1)) - (cos(q(1) + q(2)) + cos(q(1)))*(dq(1)^2 + dq(2)^2) + dq(1)*dq(2)*cos(q(1));

 