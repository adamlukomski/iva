function [djac_dq] = out_djac_dq7(q,dq)

  djac_dq(1,1)=(dq(3)^2 + dq(7)^2)*(sin(q(3) + q(7)) - q(1) + sin(q(3))) - dq(2)*dq(3) - dq(2)*...
         dq(7) + dq(7)^2*(q(1) - sin(q(3))) + dq(3)^2*q(1) - dq(3)*dq(7)*sin(q(3));
  djac_dq(2,1)=0;
  djac_dq(3,1)=dq(7)^2*(q(2) - cos(q(3))) + dq(1)*dq(3) + dq(1)*dq(7) + dq(3)^2*q(2) + (dq(3)^2 +...
          dq(7)^2)*(cos(q(3) + q(7)) - q(2) + cos(q(3))) - dq(3)*dq(7)*cos(q(3));

 