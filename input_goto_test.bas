REM Test INPUT in loop with GOTO
10 PRINT "Testing INPUT with GOTO loop"
20 LET COUNT = 1
30 PRINT "Iteration #"; COUNT
40 INPUT "Enter a number: ", X
50 PRINT "You entered: "; X
60 LET COUNT = COUNT + 1
70 IF COUNT <= 3 THEN GOTO 30
80 PRINT "Done!"
90 END
