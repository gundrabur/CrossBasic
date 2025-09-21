1 REM Comprehensive MOD operator test
2 REM Tests various MOD operations and contexts

10 PRINT "MOD Operator Comprehensive Test"
20 PRINT "==============================="

30 REM Basic MOD operations
40 PRINT "Basic MOD operations:"
50 FOR I = 1 TO 12
60 PRINT I; "MOD 3 ="; I MOD 3
70 NEXT I

80 REM MOD in complex expressions
90 PRINT
100 PRINT "Complex expressions with MOD:"
110 LET X = 17
120 LET Y = 5
130 PRINT "X ="; X; ", Y ="; Y
140 PRINT "X MOD Y ="; X MOD Y
150 PRINT "X * 2 MOD Y ="; X * 2 MOD Y
160 PRINT "(X + Y) MOD 7 ="; (X + Y) MOD 7

170 REM MOD with logical operators
180 PRINT
190 PRINT "MOD with logical operators:"
200 FOR N = 1 TO 15
210 IF N MOD 3 = 0 AND N MOD 5 = 0 THEN PRINT N; "is divisible by both 3 and 5"
220 IF N MOD 2 = 0 OR N MOD 7 = 0 THEN PRINT N; "is divisible by 2 or 7"
230 NEXT N

240 REM MOD for progress indicators (like in raytracer)
250 PRINT
260 PRINT "Progress indicator simulation:"
270 FOR S = 0 TO 100 STEP 3
280 IF S MOD 20 = 0 THEN PRINT "Progress:"; S; "%"
290 NEXT S

300 PRINT
310 PRINT "MOD operator test complete!"
320 END