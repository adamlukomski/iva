function [djac_dq] = out_djac_dq1(q,dq)

  djac_dq(1,1)=-dq(1)^2*sin(q(1));
  djac_dq(2,1)=0;
  djac_dq(3,1)=-dq(1)^2*cos(q(1));

 