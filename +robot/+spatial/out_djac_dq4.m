function [djac_dq] = out_djac_dq4(q,dq)

  djac_dq(1,1)=0;
  djac_dq(2,1)=dq(3)*dq(4);
  djac_dq(3,1)=-dq(2)*dq(4);

 