function [dpc] = out_dpc4(q,dq)

  dpc(1,1)=dq(1) - (dq(4)*cos(q(3) + q(4)))/2 - dq(3)*(cos(q(3) + q(4))/2 + cos(q(3)));
  dpc(2,1)=0;
  dpc(3,1)=dq(2) + dq(3)*(sin(q(3) + q(4))/2 + sin(q(3))) + (dq(4)*sin(q(3) + q(4)))/2;

 