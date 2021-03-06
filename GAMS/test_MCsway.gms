Sets
       i   regions   / MISO, PJM /
Parameters
       a(i)  capacity of plant in regions
         /    MISO    200
              PJM     600  /
       b(i)  demand at regions
         /    MISO    300
              PJM     500  /
       d(i)  current transmission capacity (MISO--from MISO PJM--from PJM)
         /    MISO    10
              PJM    10  /;

Scalar f  cost of expanding 1 MW of line  /100/ ;
Scalar g  cost operation generation  /30/ ;

Variables
     x(i)  generation
     y(i)  flows
     l(i)  new capacity built
     z     total transmission cost ;
Positive variables x,l;
Equations
     cost        objective function
     supply(i)   supply limit at plant i
     demand(i)   satisfy demand
     flow(i)     flow constrains
     flow_bal     flow balance ;
cost ..        z  =e=  sum(i, f*l(i))+sum(i, g*x(i)) ;
supply(i) ..   x(i)  =l=  a(i) ;
flow(i) ..  y(i)  =l=  d(i) + l(i)+ l(i++1) ;
demand(i) ..   x(i) - y(i)  =e=  b(i) ;
flow_bal..  sum(i, y(i)) =e= 0;
Model toyMod /all/ ;
Solve toyMod using lp minimizing z ;
