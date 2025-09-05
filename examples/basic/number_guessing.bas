REM Example 4: Interactive program
10 PRINT "Number Guessing Game"
20 PRINT "==================="
30 LET NUMBER = INT(RND(100)) + 1
40 LET ATTEMPTS = 0
50 PRINT "I'm thinking of a number between 1 and 100."
60 INPUT "Your guess: ", GUESS
70 LET ATTEMPTS = ATTEMPTS + 1
80 IF GUESS = NUMBER THEN GOTO 130
90 IF GUESS < NUMBER THEN PRINT "Too low!"
100 IF GUESS > NUMBER THEN PRINT "Too high!"
110 IF ATTEMPTS < 10 THEN GOTO 60
120 PRINT "Sorry, you lost! The number was "; NUMBER
130 PRINT "Congratulations! You won in "; ATTEMPTS; " attempts!"
140 END
