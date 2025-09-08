10 REM Color Demo Program for CrossBasic
20 REM Shows various text colors and backgrounds
30 PRINT "CrossBasic Color Demo"
40 PRINT "=================="
50 PRINT ""
60 REM Test foreground colors
70 PRINT "Testing foreground colors:"
80 TEXTCOLOR 2
90 PRINT "Red text"
100 TEXTCOLOR 3
110 PRINT "Green text"
120 TEXTCOLOR 4
130 PRINT "Blue text"
140 TEXTCOLOR 5
150 PRINT "Yellow text"
160 TEXTCOLOR 6
170 PRINT "Magenta text"
180 TEXTCOLOR 7
190 PRINT "Cyan text"
200 PRINT ""
210 REM Test background colors
220 TEXTCOLOR 1
230 PRINT "Testing background colors:"
240 TEXTBG 2
250 PRINT "Red background"
260 TEXTBG 3
270 PRINT "Green background"
280 TEXTBG 4
290 PRINT "Blue background"
300 TEXTBG 5
310 PRINT "Yellow background"
320 PRINT ""
330 REM Reset to default
340 RESETCOLOR
350 PRINT "Colors reset to default"
360 PRINT "Demo complete!"
370 END
