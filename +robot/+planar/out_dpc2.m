function [dpc] = out_dpc2(q,dq)

  dpc(1,1)=dq(1);
  dpc(2,1)=0;
  dpc(3,1)=dq(2);

 