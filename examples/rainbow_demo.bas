10 REM Rainbow Text Demo
20 REM Creates a colorful display
30 PRINT "=========================================="
40 TEXTCOLOR 2
50 PRINT "  ______ _______ _______  ______  _____"
60 TEXTCOLOR 3  
70 PRINT " |      |       |       |      ||  _  |"
80 TEXTCOLOR 4
90 PRINT " |   ___|   _   |    ___|  _    || | | |"
100 TEXTCOLOR 5
110 PRINT " |  |   |  | |  |   |   | | |   || |_| |"
120 TEXTCOLOR 6
130 PRINT " |  |   |  |_|  |   |___| |_|   ||     |"
140 TEXTCOLOR 7
150 PRINT " |  |___|       |_______|       ||  _  |"
160 TEXTCOLOR 15
170 PRINT " |_______|_______|_______|_______||_| |_|"
180 PRINT "=========================================="
190 RESETCOLOR
200 PRINT ""
210 PRINT "Welcome to CrossBasic with Color Support!"
220 PRINT ""
230 REM Show color palette
240 PRINT "Color Palette:"
250 FOR I = 0 TO 15
260   TEXTCOLOR I
270   PRINT "Color "; I; " - Sample Text"
280 NEXT I
290 RESETCOLOR
300 PRINT ""
310 PRINT "Colors are fun and easy to use!"
320 END
