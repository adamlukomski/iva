function [dp] = out_dp10(q,dq)

  dp(1,1)=dq(1) - dq(10)*cos(q(10));
  dp(2,1)=0;
  dp(3,1)=dq(2) + dq(10)*sin(q(10));

 