// Quadruple instructions:  (op, arg1, arg2, result);
LOAD x, 20;
LOAD y, 6;
(+, x, y, t1);    // t1 = x + y
(-, x, y, t2);    // t2 = x - y
(*, t1, t2, t3);  // t3 = t1 * t2
(/, x, y, t4);    // t4 = x / y
(%, x, y, t5);    // t5 = x % y
PRINT t1;
PRINT t2;
PRINT t3;
PRINT t4;
PRINT t5;
