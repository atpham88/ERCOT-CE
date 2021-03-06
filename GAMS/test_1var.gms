Sets
       i   regions   / MISO, PJM /
Parameters
       a(i)  capacity of plant in regions
         /    MISO    200
              PJM     600  /
       b(i)  demand at regions
         /    MISO    100
              PJM     700  /
Scalar d  current transmission line capacity  /0/ ;
Scalar f  cost of expanding 1 MW of line  /100/ ;
Scalar g  cost operation generation  /30/ ;
Variables
     x(i)  generation
     y(i)  flows away from a region
     l     new capacity built
     z     total transmission cost ;
Positive variables x,l;
Equations
     cost        objective function
     supply(i)   supply limit at plant i
     demand(i)   satisfy demand
     flow_pos(i)     flow constrains
     flow_neg(i)     flow constrains
     flow_bal     flow balance;
cost ..        z  =e=  f*l+sum(i, g*x(i)) ;
supply(i) ..   x(i)  =l=  a(i) ;
flow_pos(i) ..  y(i)  =l=  d + l ;
flow_neg(i) ..  y(i)  =g=  -d - l ;
flow_bal..  sum(i, y(i)) =e= 0;
demand(i) ..   x(i) - y(i)  =e=  b(i) ;
Model toyMod /all/ ;
Solve toyMod using lp minimizing z ;