1 REM TIME Function Examples
2 REM Shows different ways to use TIME() for benchmarking

10 PRINT "TIME Function Examples"
20 PRINT "====================="
30 PRINT

35 REM Example 1: Basic timing
40 PRINT "Example 1: Basic timing"
50 PRINT "Current timestamp:"; TIME()
60 PRINT

65 REM Example 2: Measuring execution time
70 PRINT "Example 2: Measuring execution time"
80 LET START = TIME()
90 FOR I = 1 TO 5000
100 LET X = SQR(I)
110 NEXT I
120 LET FINISH = TIME()
130 PRINT "Calculated 5000 square roots in"; FINISH - START; "seconds"
140 PRINT

145 REM Example 3: Performance comparison
150 PRINT "Example 3: Performance comparison"
160 PRINT "Testing addition vs multiplication:"

165 REM Test addition
180 LET START = TIME()
190 FOR I = 1 TO 10000
200 LET X = I + I + I + I + I
210 NEXT I
220 LET ADD_TIME = TIME() - START

225 REM Test multiplication  
240 LET START = TIME()
250 FOR I = 1 TO 10000
260 LET X = I * 5
270 NEXT I
280 LET MUL_TIME = TIME() - START

290 PRINT "Addition:"; ADD_TIME; "seconds"
300 PRINT "Multiplication:"; MUL_TIME; "seconds"

310 IF ADD_TIME < MUL_TIME THEN PRINT "Addition is faster!"
320 IF MUL_TIME < ADD_TIME THEN PRINT "Multiplication is faster!"
330 IF ADD_TIME = MUL_TIME THEN PRINT "Same performance!"

340 PRINT
350 PRINT "All examples complete!"
360 END
