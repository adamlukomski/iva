function [G] = out_lieG(q)

  G(1,1)=- (981*sin(q(1) + q(2)))/50 - (2943*sin(q(1)))/100;
  G(2,1)=-(981*sin(q(1) + q(2)))/50;

 