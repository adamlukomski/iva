function [G] = out_lieG(q)

  G(1,1)=0;
  G(2,1)=2943/50;
  G(3,1)=(981*sin(q(3) + q(4) + q(5)))/100 + (981*sin(q(3) + q(6) + q(7)))/100 + (981*sin(q(3) +...
          q(4)))/50 + (981*sin(q(3) + q(6)))/50 + (981*sin(q(3)))/20;
  G(4,1)=(981*sin(q(3) + q(4) + q(5)))/100 + (981*sin(q(3) + q(4)))/50;
  G(5,1)=(981*sin(q(3) + q(4) + q(5)))/100 + (981*sin(q(3) + q(4)))/100 + (981*sin(q(3)))/100 -...
          (981*cos(q(3))*sin(q(4)))/100 - (981*cos(q(4))*sin(q(3)))/50 + (981*sin(q(3))*(cos(q(4)) - 1))/100;
  G(6,1)=(981*sin(q(3) + q(6) + q(7)))/100 + (981*sin(q(3) + q(6)))/50;
  G(7,1)=(981*sin(q(3) + q(6) + q(7)))/100 + (981*sin(q(3) + q(6)))/100 + (981*sin(q(3)))/100 -...
          (981*cos(q(3))*sin(q(6)))/100 - (981*cos(q(6))*sin(q(3)))/50 + (981*sin(q(3))*(cos(q(6)) - 1))/100;

 