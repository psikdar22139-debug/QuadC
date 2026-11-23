// Mixed: three operand + quadruple together
LOAD a, 7;
LOAD b, 3;
ADD a, b, s;          // three operand
(*, s, a, p);         // quadruple
(MUL, p, b, q);       // quadruple with op name
SUB q, s, r;          // three operand
PRINT s;
PRINT p;
PRINT q;
PRINT r;
