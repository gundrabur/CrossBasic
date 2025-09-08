1 REM Benchmark Test - Demonstrates TIME function usage
2 REM This program shows how to benchmark BASIC code execution time

10 PRINT "CrossBasic Benchmark Demo"
20 PRINT "========================="
30 PRINT

35 REM Test 1: Simple loop benchmark
40 PRINT "Test 1: Simple counting loop"
50 LET START_TIME = TIME()
60 FOR I = 1 TO 10000
70 NEXT I
80 LET END_TIME = TIME()
90 LET ELAPSED = END_TIME - START_TIME
100 PRINT "Counted to 10000 in"; ELAPSED; "seconds"
110 PRINT

115 REM Test 2: Mathematical operations benchmark
120 PRINT "Test 2: Mathematical operations"
130 LET START_TIME = TIME()
140 FOR I = 1 TO 1000
150 LET X = SQR(I) + SIN(I) + COS(I)
160 NEXT I
170 LET END_TIME = TIME()
180 LET ELAPSED = END_TIME - START_TIME
190 PRINT "1000 math operations in"; ELAPSED; "seconds"
200 PRINT

205 REM Test 3: Nested loops benchmark
210 PRINT "Test 3: Nested loops"
220 LET START_TIME = TIME()
230 FOR I = 1 TO 100
240 FOR J = 1 TO 100
250 LET X = I * J
260 NEXT J
270 NEXT I
280 LET END_TIME = TIME()
290 LET ELAPSED = END_TIME - START_TIME
300 PRINT "100x100 nested loops in"; ELAPSED; "seconds"
310 PRINT

320 PRINT "Benchmark complete!"
330 END
