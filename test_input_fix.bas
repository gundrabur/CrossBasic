10 PRINT "Testing INPUT in loop"
20 LET COUNT = 1
30 PRINT "Try #"; COUNT
40 INPUT "Enter number: ", X
50 PRINT "Got: "; X
60 LET COUNT = COUNT + 1
70 IF COUNT <= 2 THEN GOTO 30
80 PRINT "Test complete!"
90 END
