REM Example 2: Loops and conditions
10 PRINT "Numbers from 1 to 10:"
20 FOR I = 1 TO 10
30 PRINT I;
40 NEXT I
50 PRINT
60 PRINT
70 PRINT "Even numbers from 2 to 20:"
80 FOR N = 2 TO 20 STEP 2
90 PRINT N;
100 NEXT N
110 PRINT
120 PRINT
130 PRINT "Testing input:"
140 INPUT "Enter a number: ", X
150 IF X > 10 THEN PRINT "Big number!" ELSE PRINT "Small number!"
160 END
