10 PRINT "Testing TIME function:"
20 LET T1 = TIME()
30 PRINT "Time 1:", T1
40 FOR I = 1 TO 100
50 NEXT I
60 LET T2 = TIME()
70 PRINT "Time 2:", T2
80 PRINT "Difference:", T2 - T1
90 END
