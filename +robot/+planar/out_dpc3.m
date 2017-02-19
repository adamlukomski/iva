function [dpc] = out_dpc3(q,dq)

  dpc(1,1)=dq(1) - (dq(3)*cos(q(3)))/2;
  dpc(2,1)=0;
  dpc(3,1)=dq(2) + (dq(3)*sin(q(3)))/2;

 