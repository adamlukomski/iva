function [dp] = out_dp11(q,dq)

  dp(1,1)=dq(1) - dq(11)*cos(q(11));
  dp(2,1)=0;
  dp(3,1)=dq(2) + dq(11)*sin(q(11));

 