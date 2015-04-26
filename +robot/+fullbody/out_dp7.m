function [dp] = out_dp7(q,dq)

  dp(1,1)=dq(1) - dq(7)*cos(q(3) + q(7)) - dq(3)*(cos(q(3) + q(7)) + cos(q(3)));
  dp(2,1)=0;
  dp(3,1)=dq(2) + dq(7)*sin(q(3) + q(7)) + dq(3)*(sin(q(3) + q(7)) + sin(q(3)));

 