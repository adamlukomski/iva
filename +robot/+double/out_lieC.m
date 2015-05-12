function [C] = out_lieC(q,dq)

  C(1,1)=dq(2)*(sin(q(1))*(2*cos(q(1) + q(2)) + 2*cos(q(1))) - cos(q(1))*(2*sin(q(1) + q(2)) + 2*sin(q(1))));
  C(1,2)=dq(1)*(sin(q(1))*(2*cos(q(1) + q(2)) + 2*cos(q(1))) - cos(q(1))*(2*sin(q(1) + q(2)) + 2*...
         sin(q(1)))) + dq(2)*(2*cos(q(1) + q(2))*sin(q(1)) - 2*sin(q(1) + q(2))*cos(q(1)));
  C(2,1)=-dq(1)*(sin(q(1))*(2*cos(q(1) + q(2)) + 2*cos(q(1))) - cos(q(1))*(2*sin(q(1) + q(2)) + 2*sin(q(1))));
  C(2,2)=0;

 