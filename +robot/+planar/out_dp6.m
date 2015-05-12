function [dp] = out_dp6(q,dq)

  dp(1,1)=dq(1) - dq(6)*cos(q(3) + q(6)) - dq(3)*(cos(q(3) + q(6)) + cos(q(3)));
  dp(2,1)=0;
  dp(3,1)=dq(2) + dq(6)*sin(q(3) + q(6)) + dq(3)*(sin(q(3) + q(6)) + sin(q(3)));

 