function [pc] = out_pc2(q)

  pc(1,1)=q(1);
  pc(2,1)=0;
  pc(3,1)=q(2);
  pc(4,1)=1;

 